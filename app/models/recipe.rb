class Recipe < ApplicationRecord
  has_many :ingredients
  has_many :recipes_ingredients
end
