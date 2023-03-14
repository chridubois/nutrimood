class Condition < ApplicationRecord
  belongs_to :symptom, optional: true
  belongs_to :mood
  belongs_to :user
  belongs_to :recipe, optional: true
  has_many :symptoms_by_conditions
  has_many :symptoms, through: :symptoms_by_conditions
end
