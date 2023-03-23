class AddUrlColumnsToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :website_source, :string, null: false
    add_column :recipes, :website_url, :string, null: false
  end
end
