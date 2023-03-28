class IngredientsFamily < ApplicationRecord
  belongs_to :family
  belongs_to :ingredient
end
