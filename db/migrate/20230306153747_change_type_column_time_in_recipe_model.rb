class ChangeTypeColumnTimeInRecipeModel < ActiveRecord::Migration[7.0]
  def change
    change_column :recipe, :time, :integer
  end
end
