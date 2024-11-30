const puppeteer = require('puppeteer');
const fs = require('fs');

const BASE_URL = "http://www25.receita.fazenda.gov.br";

async function scrapeEditais() {
    const browser = await puppeteer.launch({ headless: true });
    const page = await browser.newPage();
    
    await page.goto(`${BASE_URL}/sle-sociedade/portal`, { waitUntil: 'networkidle2' });
    
    try {
        await page.waitForSelector('tbody tr', { timeout: 60000 });

        const rows = await page.$$eval('tbody tr', rows => {
            return rows.map(row => {
                const link = row.querySelector('td.col-edital a') ? row.querySelector('td.col-edital a').href : '';
                const descricao = row.querySelector('td.col-edital a') ? row.querySelector('td.col-edital a').textContent.trim().split(' ').pop() : '';
                const codigo = row.querySelector('td.col-edital a') ? row.querySelector('td.col-edital a').textContent.trim() : '';
                const dataInicio = row.querySelector('td:nth-of-type(3) span') ? row.querySelector('td:nth-of-type(3) span').textContent.trim() : '';
                const dataTermino = row.querySelector('td.hidden-xs:nth-of-type(4)') ? row.querySelector('td.hidden-xs:nth-of-type(4)').textContent.trim() : '';
                const lotes = row.querySelector('td.hidden-xs:last-child') ? parseInt(row.querySelector('td.hidden-xs:last-child').textContent.trim(), 10) : 0;

                return {
                    link,
                    codigo,
                    descricao,
                    data_inicio: dataInicio,
                    data_termino: dataTermino,
                    lotes,
                };
            });
        });

        const editaisDetalhados = [];
        for (const edital of rows) {
            if (edital.link) {
                const detalhes = await scrapeLotes(browser, edital.link);
                editaisDetalhados.push({ ...edital, lotesDetalhes: detalhes });
            }
        }

        await browser.close();
        return editaisDetalhados;
    } catch (error) {
        console.error(`Erro ao acessar ${BASE_URL}: ${error.message}`);
        await browser.close();
        return [];
    }
}

async function scrapeLotes(browser, link) {
    const page = await browser.newPage();
    await page.goto(link, { waitUntil: 'networkidle2' });

    try {
        await page.waitForSelector('table.table.table-striped', { timeout: 60000 });

        const lotes = await page.$$eval('tbody tr', rows => {
            return rows.map(row => {
                const lote = row.querySelector('td.text-left a') ? row.querySelector('td.text-left a').textContent.trim() : '';
                const precoMinimo = row.querySelector('td.text-right div.valor-lote') ? row.querySelector('td.text-right div.valor-lote').textContent.trim() : '';
                const tipo = row.querySelector('td:nth-of-type(3)') ? row.querySelector('td:nth-of-type(3)').textContent.trim() : '';
                const situacao = row.querySelector('td:nth-of-type(4)') ? row.querySelector('td:nth-of-type(4)').textContent.trim() : '';
                const avisosErratas = row.querySelector('td.text-center a span') ? row.querySelector('td.text-center a span').textContent.trim() : '';

                return {
                    lote,
                    preco_minimo: precoMinimo,
                    tipo,
                    situacao,
                    avisos_erratas: avisosErratas,
                };
            });
        });

        await page.close();
        return lotes;
    } catch (error) {
        console.error(`Erro ao acessar os lotes no link ${link}: ${error.message}`);
        await page.close();
        return [];
    }
}

function saveToJson(data, fileName = 'editais_completos.json') {
    fs.writeFileSync(fileName, JSON.stringify(data, null, 4), 'utf-8');
    console.log(`Dados salvos em ${fileName}`);
}

async function main() {
    const editais = await scrapeEditais();
    if (editais.length > 0) {
        saveToJson(editais);
    } else {
        console.log('Nenhum edital encontrado.');
    }
}

main();
