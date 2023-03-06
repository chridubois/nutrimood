class Nutrient < ApplicationRecord
  has_many :nutrients_by_ingredients
end
