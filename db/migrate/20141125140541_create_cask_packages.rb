class CreateCaskPackages < ActiveRecord::Migration
  def change
    create_table :cask_packages do |t|
      t.references :cask, index: true
      t.references :package, index: true

      t.timestamps
    end
  end
end
