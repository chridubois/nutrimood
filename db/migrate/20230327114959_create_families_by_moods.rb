class CreateFamiliesByMoods < ActiveRecord::Migration[7.0]
  def change
    create_table :families_by_moods do |t|
      t.references :family, null: false, foreign_key: true
      t.references :mood, null: false, foreign_key: true
      t.string :anecdote
      t.boolean :is_good
      t.boolean :is_bad

      t.timestamps
    end
  end
end
