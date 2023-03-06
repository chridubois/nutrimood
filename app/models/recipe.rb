class Recipe < ApplicationRecord
  has_many :recipes_steps
  has_many :ingredients
  has_many :recipes_ingredients
end
