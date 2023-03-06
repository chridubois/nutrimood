class Ingredient < ApplicationRecord
  has_many :recipes_ingredients
  has_many :ingredient_by_symptoms
  has_many :nutrients_by_ingredients
  has_many :restrictions_ingredients_users
end
