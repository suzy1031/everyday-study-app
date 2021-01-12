class ChangeDataTargetTimeTogoal < ActiveRecord::Migration[5.2]
  def change
    change_column :goals, :target_time, :float, null: false
  end
end
