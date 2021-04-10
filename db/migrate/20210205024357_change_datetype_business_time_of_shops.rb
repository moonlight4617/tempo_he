class ChangeDatetypeBusinessTimeOfShops < ActiveRecord::Migration[5.2]
  def change
    change_column :shops, :business_time, :text, array: true
  end
end
