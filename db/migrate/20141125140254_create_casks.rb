class CreateCasks < ActiveRecord::Migration
  def change
    create_table :casks do |t|
      t.references :user, index: true
      t.string :url
      t.string :raw_url
      t.boolean :read, default: false
      t.boolean :configuration

      t.timestamps
    end
  end
end
