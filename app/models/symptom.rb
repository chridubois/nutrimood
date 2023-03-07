class Symptom < ApplicationRecord
  has_many :conditions
  has_many :ingredients_by_symptoms
end
