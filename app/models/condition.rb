class Condition < ApplicationRecord
  belongs_to :symptom
  belongs_to :mood
  belongs_to :user
end
