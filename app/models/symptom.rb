class Symptom < ApplicationRecord
  has_many :ingredients_by_symptoms
  has_many :symptoms_by_conditions
  has_many :ingredients, through: :ingredients_by_symptoms

  validates :name, uniqueness: true
end
