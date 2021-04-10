class AddNameToShop < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :name, :string
  end
end
