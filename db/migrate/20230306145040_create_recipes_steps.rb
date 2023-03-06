class CreateRecipesSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes_steps do |t|
      t.integer :step_number
      t.string :step_description
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
