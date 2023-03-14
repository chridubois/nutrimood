class Recipe < ApplicationRecord
  has_many :recipes_steps
  has_many :recipes_ingredients
  has_many :conditions
  has_many :ingredients, through: :recipes_ingredients
  has_many :ingredients_by_symptoms, through: :ingredients

  validates :name, uniqueness: true
end
