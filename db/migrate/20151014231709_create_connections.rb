class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.string :db_name
      t.string :db_host
      t.string :db_username
      t.string :db_password

      t.timestamps null: false
    end
  end
end
