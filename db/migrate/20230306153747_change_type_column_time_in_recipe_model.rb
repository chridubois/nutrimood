class ChangeTypeColumnTimeInRecipeModel < ActiveRecord::Migration[7.0]
  def change
    change_column :recipes, :time, :integer
  end
end
