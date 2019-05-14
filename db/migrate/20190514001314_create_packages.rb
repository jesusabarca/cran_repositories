class CreatePackages < ActiveRecord::Migration[5.2]
  def change
    create_table :packages do |t|
      t.string :name, null: false
      t.string :version, null: false
      t.datetime :published_at
      t.string :title
      t.text :description

      t.timestamps
      t.index %i[name version], unique: true
    end
  end
end
