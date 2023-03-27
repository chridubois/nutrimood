class CreateFamiliesBySymptoms < ActiveRecord::Migration[7.0]
  def change
    create_table :families_by_symptoms do |t|
      t.references :family, null: false, foreign_key: true
      t.references :symptom, null: false, foreign_key: true
      t.string :anecdote
      t.boolean :is_good
      t.boolean :is_bad

      t.timestamps
    end
  end
end
