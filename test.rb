require 'csv'
require 'open-uri'
require 'nokogiri'

url = "https://lescommis.com/recettes/facile/?page=1"
html_file = URI.open(url).read
html_doc = Nokogiri::HTML.parse(html_file)

recipe_urls =  html_doc.xpath("//div[contains(@class, 'recipe-name')]/a/@href").map { |attr| "https://lescommis.com" + attr.value }

url = "https://lescommis.com/recettes/crevettes-pili-pili-pommes-de-terre-au-citron-ail/"

  # For each recipe, get recipe infos
  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML.parse(html_file)

  # Get Recipe name
  name = html_doc.search('h1').text
  time = html_doc.xpath("//div[contains(@class, 'header__time-value')]").text.split("\n")[3].strip.split.first.to_i
  # Get Recipe image
  image = html_doc.xpath("//div[@class='q-img__image absolute-full']")
  p image

  ingredients = html_doc.xpath("//div[@class='q-item__section column ingredient__section q-item__section--main justify-center']")
  p ingredients.count
