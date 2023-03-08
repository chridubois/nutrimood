class DeleteSymptomColumnFromCondition < ActiveRecord::Migration[7.0]
  def change
    remove_column :conditions, :symptom_id
  end
end
