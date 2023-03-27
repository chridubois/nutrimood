class FamiliesByMood < ApplicationRecord
  belongs_to :mood
  belongs_to :family
  has_many :ingredients_families, through: :family
  has_many :ingredients, through: :ingredients_families
end
