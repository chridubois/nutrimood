class IngredientBySymptom < ApplicationRecord
  belongs_to :symptom
  belongs_to :ingredient
end
