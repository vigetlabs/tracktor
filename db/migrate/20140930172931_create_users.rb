class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :token
      t.string :email
      t.string :full_name
      t.string :harvest_access_token
      t.string :harvest_refresh_token

      t.timestamps
    end
  end
end
