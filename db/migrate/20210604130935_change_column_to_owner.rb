class ChangeColumnToOwner < ActiveRecord::Migration[5.2]
  def change
    change_column :owners, :tel, :string
  end
end
