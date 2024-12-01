const puppeteer = require('puppeteer');
const fs = require('fs');
const axios = require('axios'); // Biblioteca para fazer requisições HTTP para o backend

const BASE_URL = "http://www25.receita.fazenda.gov.br";

// Max concurrent requests per batch to avoid memory overload
const BATCH_SIZE = 50;

async function scrapeNotices() {
    console.time('TotalRuntime');

    const browser = await puppeteer.launch({ headless: true });
    const page = await browser.newPage();

    await page.goto(`${BASE_URL}/sle-sociedade/portal`, { waitUntil: 'networkidle2' });

    try {
        await page.waitForSelector('tbody tr', { timeout: 60000 });

        const rows = await page.$$eval('tbody tr', rows => {
            return rows.map(row => {
                const link = row.querySelector('td.col-edital a') ? row.querySelector('td.col-edital a').href : '';
                const description = row.querySelector('td.col-edital a') ? row.querySelector('td.col-edital a').textContent.trim().split(' ').pop() : '';
                const code = row.querySelector('td.col-edital a') ? row.querySelector('td.col-edital a').textContent.trim() : '';
                const startDate = row.querySelector('td:nth-of-type(3) span') ? row.querySelector('td:nth-of-type(3) span').textContent.trim() : '';
                const endDate = row.querySelector('td.hidden-xs:nth-of-type(4)') ? row.querySelector('td.hidden-xs:nth-of-type(4)').textContent.trim() : '';
                const lots = row.querySelector('td.hidden-xs:last-child') ? parseInt(row.querySelector('td.hidden-xs:last-child').textContent.trim(), 10) : 0;

                return {
                    link,
                    code,
                    description,
                    start_date: startDate,
                    end_date: endDate,
                    lots,
                };
            });
        });

        const detailedNotices = await scrapeLotTablesInBatch(browser, rows);

        // Salve os dados no banco de dados
        await saveNoticesToDB(detailedNotices);

        await browser.close();
        console.timeEnd('TotalRuntime');
        return detailedNotices;
    } catch (error) {
        console.error(`Error accessing ${BASE_URL}: ${error.message}`);
        await browser.close();
        console.timeEnd('TotalRuntime');
        return [];
    }
}

async function scrapeLotTablesInBatch(browser, notices) {
    const allDetailedNotices = [];

    for (const element of notices) {
        const notice = element;
        const lots = await scrapeLots(browser, notice);

        const lotTablesInBatch = await scrapeLotDetailsForLotsInBatch(browser, lots, notice.link);
        allDetailedNotices.push({ ...notice, lots_details: lotTablesInBatch });
    }

    return allDetailedNotices;
}

async function scrapeLots(browser, notice) {
    const page = await browser.newPage();
    await page.goto(notice.link, { waitUntil: 'networkidle2' });

    const lots = [];

    try {
        while (true) {
            await page.waitForSelector('table.table.table-striped tbody tr', { timeout: 60000 });

            const pageLots = await page.$$eval('tbody tr', (rows, link) => {
                return rows.map(row => {
                    const lot = row.querySelector('td.text-left a') ? row.querySelector('td.text-left a').textContent.trim() : '';
                    const minPrice = row.querySelector('td.text-right div.valor-lote') ? row.querySelector('td.text-right div.valor-lote').textContent.trim() : '';
                    const type = row.querySelector('td:nth-of-type(3)') ? row.querySelector('td:nth-of-type(3)').textContent.trim() : '';
                    const status = row.querySelector('td:nth-of-type(4)') ? row.querySelector('td:nth-of-type(4)').textContent.trim() : '';
                    const errataWarnings = row.querySelector('td.text-center a span') ? row.querySelector('td.text-center a span').textContent.trim() : '';
                    const person = row.querySelector('icone-tipo-clientela img') ? row.querySelector('icone-tipo-clientela img').title : '';

                    return {
                        lot,
                        min_price: minPrice,
                        type,
                        status,
                        person,
                        errata_warnings: errataWarnings,
                        link: link ? link + '/lote/' + lot.replace('Lote ', '').trim() : ''
                    };
                });
            }, notice.link);

            lots.push(...pageLots);

            const nextButton = await page.$('li.pagination-next a');
            const isDisabled = nextButton
                ? await page.evaluate(button => button.closest('li').classList.contains('disabled'), nextButton)
                : true;

            if (isDisabled) {
                break;
            }

            await Promise.all([
                nextButton.click(),
                page.waitForNavigation({ waitUntil: 'networkidle2' }),
            ]);
        }

        await page.close();
        return lots;
    } catch (error) {
        console.error(`Error accessing lots at ${notice.link}: ${error.message}`);
        await page.close();
        return [];
    }
}

async function scrapeLotDetailsForLotsInBatch(browser, lots, link) {
    const allLotDetails = [];

    for (let i = 0; i < lots.length; i += BATCH_SIZE) {
        const batch = lots.slice(i, i + BATCH_SIZE);
        const batchPromises = batch.map(lot => scrapeLotTable(browser, link, lot.lot));
        const batchResults = await Promise.all(batchPromises);
        allLotDetails.push(...batchResults);
    }

    return lots.map((lot, index) => ({
        ...lot,
        lot_table: allLotDetails[index] || [],
        link
    }));
}

async function scrapeLotTable(browser, link, lotId) {
    if (!lotId || lotId.trim() === "") {
        return [];
    }

    const page = await browser.newPage();

    const lotNumber = lotId.replace('Lote ', '').trim();
    if (!lotNumber) {
        return [];
    }

    const lotUrl = `${link}/lote/${lotId.replace('Lote ', '').trim()}`;

    await page.goto(lotUrl, { waitUntil: 'networkidle2' });

    try {
        await page.waitForSelector('table.table-striped tbody tr', { timeout: 60000 });

        const lotTable = await page.$$eval('table.table-striped tbody tr', rows => {
            return rows.map(row => {
                const venue = row.querySelector('td:nth-of-type(1)') ? row.querySelector('td:nth-of-type(1)').textContent.trim() : '';
                const quantity = row.querySelector('td:nth-of-type(2)') ? row.querySelector('td:nth-of-type(2)').textContent.trim() : '';
                const unit = row.querySelector('td:nth-of-type(3)') ? row.querySelector('td:nth-of-type(3)').textContent.trim() : '';
                const description = row.querySelector('td:nth-of-type(4)') ? row.querySelector('td:nth-of-type(4)').textContent.trim() : '';

                return {
                    venue,
                    quantity,
                    unit,
                    description
                };
            });
        });

        await page.close();
        return lotTable;
    } catch (error) {
        console.error(`Error accessing table for lot ${lotId}: ${error.message}`);
        await page.close();
        return [];
    }
}

async function saveNoticesToDB(notices) {
    const backendApiUrl = process.env.BACKEND_API_URL;  // Get the backend URL from the environment

    if (!backendApiUrl) {
        console.error("BACKEND_API_URL is not defined in .env");
        return;
    }

    for (let notice of notices) {
        // Salve o edital
        const savedNotice = await axios.post(`${backendApiUrl}/notices`, {
            code: notice.code,
            description: notice.description,
            start_date: notice.start_date,
            end_date: notice.end_date,
            lots_count: notice.lots,
        });

        // Salve os lotes associados a esse edital
        for (let lot of notice.lots_details) {
            if (lot.lot) {
                await axios.post(`${backendApiUrl}/lots`, {
                    notice_id: savedNotice.data.id,
                    lot_number: lot.lot,
                    min_price: lot.min_price,
                    lot_type: lot.type,
                    status: lot.status,
                    person: lot.person,
                    errata_warnings: lot.errata_warnings,
                });
            }
        }
    }
}

async function main() {
    const notices = await scrapeNotices();
    if (notices.length > 0) {
        console.log("Notices saved successfully.");
    }
}

main();
