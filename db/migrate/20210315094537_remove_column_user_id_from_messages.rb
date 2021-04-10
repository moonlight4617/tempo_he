class RemoveColumnUserIdFromMessages < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :user_id, :biginst
    remove_column :messages, :shop_id, :integer
  end
end
