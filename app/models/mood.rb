class Mood < ApplicationRecord
  has_many :ingredients_by_moods
  has_many :conditions
end
