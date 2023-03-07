require 'csv'

# Création des moods
CSV.foreach(Rails.root.join('lib/moods.csv'), headers: false) do |row|
  p "Creating mood #{row[0]}"
  Mood.create({
    name: row[0]
  })
end

# Création des symptomes
CSV.foreach(Rails.root.join('lib/symptoms.csv'), headers: false) do |row|
  p "Creating mood #{row[0]}"
  Symptom.create({
    name: row[0]
  })
end
