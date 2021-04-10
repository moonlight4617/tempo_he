class AddColumnToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :shop_id, :integer
    add_column :messages, :user_id, :integer
  end
end
