class RestrictionsIngredientsUser < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient

  validates :user, uniqueness: { scope: :ingredient }
end
