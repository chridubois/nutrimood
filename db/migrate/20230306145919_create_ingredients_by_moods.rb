class CreateIngredientsByMoods < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients_by_moods do |t|
      t.string :anecdote
      t.references :mood, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
