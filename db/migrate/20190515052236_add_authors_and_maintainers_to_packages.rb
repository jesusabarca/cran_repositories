class AddAuthorsAndMaintainersToPackages < ActiveRecord::Migration[5.2]
  def change
    add_column :packages, :authors, :string
    add_column :packages, :maintainers, :string
  end
end
