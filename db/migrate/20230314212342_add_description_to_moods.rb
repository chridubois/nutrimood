class AddDescriptionToMoods < ActiveRecord::Migration[7.0]
  def change
    add_column :moods, :description, :text, null: false, default: false
  end
end
