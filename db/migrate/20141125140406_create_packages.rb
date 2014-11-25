class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.string :url
      t.string :repo_type
      t.text :description

      t.timestamps
    end
    add_index :packages, :name
  end
end
