class Change2TypeColumnTimeInRecipeModel < ActiveRecord::Migration[7.0]
  def change
      remove_column :recipes, :time, :date
      add_column :recipes, :duration, :integer
  end
end
