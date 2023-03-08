class AddNewColumnsToIngredientsByMoods < ActiveRecord::Migration[7.0]
  def change
    add_column :ingredients_by_moods, :is_good, :boolean
    add_column :ingredients_by_moods, :is_bad, :boolean
  end
end
