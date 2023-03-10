class CreateRecipesIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes_ingredients do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.integer :quantity
      t.string :unit

      t.timestamps
    end
  end
end
