class WebScrappersController < ApplicationController
  def index
  end

  def new
    WebScrapper.crawl!
  end

  def download
    send_file(
      "#{Rails.root}/results.json",
      filename: "scraping_data.json",
      type: "application/json"
    )
  end
end
