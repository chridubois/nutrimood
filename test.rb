require 'csv'
require 'open-uri'

url = "https://lescommis.com/recettes/facile/?page=1"
html_file = URI.open(url).read
html_doc = Nokogiri::HTML.parse(html_file)

p html_doc.xpath('//recipe-name//a/@href')
