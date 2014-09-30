class CreateButtons < ActiveRecord::Migration
  def change
    create_table :buttons do |t|
      t.integer :number
      t.integer :task_id
      t.integer :user_id

      t.timestamps
    end
  end
end
