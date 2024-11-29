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

        await browser.close();
        return rows;
    } catch (error) {
        console.error(`Erro ao acessar ${BASE_URL}: ${error.message}`);
        await browser.close();
        return [];
    }
}

function saveToJson(data, fileName = 'editais.json') {
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
