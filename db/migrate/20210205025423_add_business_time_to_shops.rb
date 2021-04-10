class AddBusinessTimeToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :business_time, :text
  end
end
