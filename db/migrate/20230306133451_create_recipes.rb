class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :image
      t.date :time
      t.string :complexity
      t.integer :calories_by_person

      t.timestamps
    end
  end
end
