class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.date :date
      t.integer :button_id
      t.integer :task_id
      t.integer :harvest_id

      t.timestamps
    end
  end
end
