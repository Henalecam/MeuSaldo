class AuctionScraper
  def scrape_notices
    # Chama o script JS utilizando o sistema
    result = `node script/auction-scraper.js`

    if result.present?
      notices = JSON.parse(result)
      saveNoticesToDB(notices)
    else
      Rails.logger.info "Nenhum edital encontrado para scrape."
    end
  end

  private

  def saveNoticesToDB(notices)
    notices.each do |notice|
      saved_notice = Notice.create({
        code: notice['code'],
        description: notice['description'],
        start_date: notice['start_date'],
        end_date: notice['end_date'],
        lots_count: notice['lots']
      })

      notice['lots_details'].each do |lot|
        Lot.create({
          notice_id: saved_notice.id,
          lot: lot['lot'],
          min_price: lot['min_price'],
          lot_type: lot['type'],
          status: lot['status'],
          person: lot['person'],
          errata_warnings: lot['errata_warnings']
        })
      end
    end
  end
end
