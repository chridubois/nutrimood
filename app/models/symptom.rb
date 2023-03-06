class Symptom < ApplicationRecord
  has_many :ingredients_by_symptom
end
