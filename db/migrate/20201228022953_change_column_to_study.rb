class ChangeColumnToStudy < ActiveRecord::Migration[5.2]
  def change
    change_column :studies, :time, :float, null: false
    change_column :studies, :total, :float, null: false
    change_column :studies, :user_id, :integer, null: false
  end
end
