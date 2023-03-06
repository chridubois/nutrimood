class CreateIngredientsBySymptoms < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients_by_symptoms do |t|
      t.references :symptom, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.string :anecdote

      t.timestamps
    end
  end
end
