class NutrientsByIngredient < ApplicationRecord
  belongs_to :nutrient
  belongs_to :ingredient
end
