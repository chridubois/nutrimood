class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :firstname, :string
    add_column :users, :birthday_date, :date
    add_column :users, :weight, :integer
    add_column :users, :height, :integer
    add_column :users, :is_gluten_sensitive, :boolean
    add_column :users, :is_diabetic, :boolean
    add_column :users, :is_pregnant, :boolean
    add_column :users, :gender, :string
  end
end
