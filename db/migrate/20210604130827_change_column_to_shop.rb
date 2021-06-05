class ChangeColumnToShop < ActiveRecord::Migration[5.2]
  def change
    change_column :shops, :tel, :string
  end
end
