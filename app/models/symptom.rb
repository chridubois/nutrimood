class Symptom < ApplicationRecord
  has_many :ingredients_by_symptoms
  has_many :symptoms_by_conditions
end
