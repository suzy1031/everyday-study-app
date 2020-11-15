class CreateStudies < ActiveRecord::Migration[5.2]
  def change
    create_table :studies do |t|
      t.float :time
      t.float :total
      t.integer :user_id

      t.timestamps
    end
  end
end
