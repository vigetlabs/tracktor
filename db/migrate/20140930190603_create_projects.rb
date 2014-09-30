class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :client_name
      t.string :name
      t.integer :harvest_id
      t.integer :user_id

      t.timestamps
    end
  end
end
