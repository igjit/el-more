class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :name
      t.string :url
      t.string :avatar_url
      t.integer :followers
      t.integer :following

      t.timestamps
    end
    add_index :users, :name
  end
end
