class IngredientsByMood < ApplicationRecord
  belongs_to :mood
  belongs_to :ingredient
end
