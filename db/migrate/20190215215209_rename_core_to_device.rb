class RenameCoreToDevice < ActiveRecord::Migration
  def change
    rename_column :users, :core_id, :device_id
  end
end
