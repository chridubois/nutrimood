require 'csv'
require 'open-uri'

class FullLesCommisScrapJob
  include Sidekiq::Job

  def perform
    # Get the old recipe
    old_recipes_url = []
    CSV.foreach(Rails.root.join('lib/recipes.csv'), headers: true, :col_sep => ";") do |row|
      old_recipes_url << row["website_url"]
    end
    recipe_id = old_recipes_url.count + 1

    # Get the old ingredients
    old_ingredient_names = []
    CSV.foreach(Rails.root.join('lib/ingredients.csv'), headers: true, :col_sep => ";") do |row|
      old_ingredient_names << row["name"]
    end
    ingredient_id = old_ingredient_names.count + 1

    # Get the old recipe_ingredients
    old_recipe_ingredients_concat = []
    CSV.foreach(Rails.root.join('lib/recipe_ingredients.csv'), headers: true, :col_sep => ";") do |row|
      old_recipe_ingredients_concat << (row["recipe_id"].to_s + row["ingredient_id"].to_s)
    end
    recipe_ingredient_id = old_recipe_ingredients_concat.count + 1

    # Get the old recipe_steps
    old_recipe_steps = []
    CSV.foreach(Rails.root.join('lib/recipe_steps.csv'), headers: true, :col_sep => ";") do |row|
      old_recipe_steps << (row["recipe_id"].to_s + row["step_number"].to_s)
    end
    recipe_step_id = old_recipe_steps.count + 1

    # Definition of number of page to scrap
    pages_count = 1

    while pages_count < 2

      url = "https://lescommis.com/recettes/facile/?page=#{pages_count}"
      html_file = URI.open(url).read
      html_doc = Nokogiri::HTML.parse(html_file)

      # Get all recipes
      p "Création des Recettes de la page #{pages_count}"
      recipe_urls = html_doc.xpath('//recipe-name//a/@href').map { |attr| attr.value unless old_recipes_url.include?(attr.value) }.compact
      p recipe_urls

      recipe_urls.each do |url|
        # For each recipe, get recipe infos
        html_file = URI.open(url).read
        html_doc = Nokogiri::HTML.parse(html_file)

        # Get Recipe name
        name = html_doc.search('.wprm-recipe-container h2').text

        # Get Recipe prep_time
        prep_time = html_doc.search('.wprm-recipe-details.wprm-recipe-details-minutes.wprm-recipe-prep_time.wprm-recipe-prep_time-minutes').text.to_i

        # Get Recipe cook_time
        cook_time = html_doc.search('.wprm-recipe-details.wprm-recipe-details-minutes.wprm-recipe-cook_time.wprm-recipe-cook_time-minutes').text.to_i

        # Get Recipe calories
        calories = html_doc.search('.wprm-recipe-details.wprm-recipe-nutrition.wprm-recipe-calories.wprm-block-text-normal').text.to_i

        # Get Recipe image
        next if html_doc.search('.wprm-recipe-image img').attr('data-lazy-src').nil?

        image = html_doc.search('.wprm-recipe-image img').attr('data-lazy-src').text

        # Get Recipe count of people
        count_people = html_doc.search('.wprm-recipe-servings').text.to_i

        # Save into the recipe CSV file all new recipes freshly scraped
        CSV.open(Rails.root.join('lib/recipes.csv'), "ab", headers: true, :col_sep => ";") do |csv|
          unless old_recipes_url.include?(url)
            csv << [recipe_id, name, calories, prep_time + cook_time, image, "recettehealthy", url]
            old_recipes_url << url
            # Get Recipe Ingredients
            ingredients = html_doc.search('li.wprm-recipe-ingredient')
            i = 0
            ingredients.each do |ingredient|
              quantity = ingredient.xpath('//span[@class="wprm-recipe-ingredient-amount"]').collect(&:text)[i].to_i
              quantity_calc = (quantity / count_people.to_f).ceil(2)
              unit = ingredient.xpath('//span[@class="wprm-recipe-ingredient-unit"]').collect(&:text)[i]
              name = ingredient.xpath('//span[@class="wprm-recipe-ingredient-name"]').collect(&:text)[i]

              # Save into the ingredients CSV file all new ingredients freshly scraped
              CSV.open(Rails.root.join('lib/ingredients.csv'), "ab", headers: true, :col_sep => ";") do |csv|
                unless old_ingredient_names.include?(name)
                  csv << [ingredient_id, name]
                  old_ingredient_names << name
                  ingredient_id += 1
                end
              end

              # Save into the recipe_ingredients CSV file all new combinaisons freshly scraped
              CSV.open(Rails.root.join('lib/recipe_ingredients.csv'), "ab", headers: true, :col_sep => ";") do |csv|
                unless old_recipe_ingredients_concat.include?(recipe_id.to_s + ingredient_id.to_s)
                  csv << [recipe_ingredient_id, recipe_id, ingredient_id, quantity_calc, unit]
                  old_recipe_ingredients_concat << (recipe_id.to_s + ingredient_id.to_s)
                  recipe_ingredient_id += 1
                end
              end
              i += 1
            end

            # Get Recipe steps
            steps = html_doc.search('li.wprm-recipe-instruction')
            i = 0
            steps.each do |step|
              # Save into the recipe_steps CSV file all new recipe steps freshly scraped
              CSV.open(Rails.root.join('lib/recipe_steps.csv'), "ab", headers: true, :col_sep => ";") do |csv|
                unless old_recipe_steps.include?(recipe_id + (i + 1))
                  csv << [recipe_step_id, recipe_id, i + 1, step.text]
                  old_recipe_steps << (recipe_id.to_s + (i + 1).to_s)
                  recipe_step_id += 1
                end
              end
              i += 1
            end
            recipe_id += 1
          end
        end
      end
      pages_count += 1
    end
  end
end
