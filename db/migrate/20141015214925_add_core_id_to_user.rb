class AddCoreIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :core_id, :string
  end
end
