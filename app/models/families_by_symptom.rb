class FamiliesBySymptom < ApplicationRecord
  belongs_to :symptom
  belongs_to :family
  has_many :ingredients_families, through: :family
  has_many :ingredients, through: :ingredients_families
end
