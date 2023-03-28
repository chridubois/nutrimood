class Family < ApplicationRecord
  has_many :ingredients_family
  has_many :ingredients, through: :ingredients_family

  validates :name, uniqueness: true
end
