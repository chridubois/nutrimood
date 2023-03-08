class Mood < ApplicationRecord
  has_many :ingredients_by_moods
  has_many :conditions
  has_many :ingredients, through: :ingredients_by_moods
end
