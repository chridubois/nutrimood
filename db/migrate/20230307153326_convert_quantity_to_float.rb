class ConvertQuantityToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :recipes_ingredients, :quantity, :float
  end
end
