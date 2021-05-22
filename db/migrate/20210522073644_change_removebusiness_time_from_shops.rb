class ChangeRemovebusinessTimeFromShops < ActiveRecord::Migration[5.2]
  def change
    change_column :shops, :business_time, 'text USING CAST(business_time AS text)'
  end
end
