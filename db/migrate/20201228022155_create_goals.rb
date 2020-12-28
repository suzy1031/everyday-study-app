class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.integer :target_time, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
