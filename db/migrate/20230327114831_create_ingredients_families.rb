class CreateIngredientsFamilies < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients_families do |t|
      t.references :family, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
