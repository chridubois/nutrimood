class AddNewColumnsToIngredientsBySymptoms < ActiveRecord::Migration[7.0]
  def change
    add_column :ingredients_by_symptoms, :is_good, :boolean
    add_column :ingredients_by_symptoms, :is_bad, :boolean
  end
end
