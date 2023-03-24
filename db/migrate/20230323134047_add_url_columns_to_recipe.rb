class AddUrlColumnsToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :website_source, :string
    add_column :recipes, :website_url, :string
  end
end
