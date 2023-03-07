class Condition < ApplicationRecord
  belongs_to :symptom, optional: true
  belongs_to :mood
  belongs_to :user
end
