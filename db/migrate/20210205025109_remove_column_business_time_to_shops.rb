class RemoveColumnBusinessTimeToShops < ActiveRecord::Migration[5.2]
  def change
    remove_column :shops, :business_time, :text, array: true
  end
end
