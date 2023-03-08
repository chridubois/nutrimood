class Recipe < ApplicationRecord
  has_many :recipes_steps
  has_many :recipes_ingredients
  has_many :ingredients, through: :recipes_ingredients
end
