require 'kimurai'
require 'uri'
require 'selenium-webdriver'

class RecettehealthyScrap < Kimurai::Base
  @name = "recette_healthy_scrap"
  @engine = :mechanize
  @start_urls = ["http://recettehealthy.com/les-recette-salee/plat-complet"]

  def parse(response, url:, data: {})
    posts_headers_path = "//article//a/@href"
    count = response.xpath(posts_headers_path).count

    loop do
      browser.execute_script("window.scrollBy(0,10000)") ; sleep 2
      response = browser.current_response

      new_count = response.xpath(posts_headers_path).count
      if count == new_count
        logger.info "> Pagination is done" and break
      else
        count = new_count
        logger.info "> Continue scrolling, current count is #{count}..."
      end
    end

    posts_headers = response.xpath(posts_headers_path).map(&:text)
    logger.info "> All posts from page: #{posts_headers.join('; ')}"
  end
end

# p URI.parse("https://recettehealthy.com/les-recette-salee/plat-complet/").kind_of?(URI::HTTP)

RecettehealthyScrap.crawl!
