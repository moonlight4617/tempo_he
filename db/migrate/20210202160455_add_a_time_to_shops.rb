class AddATimeToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :start_time, :integer
    add_column :shops, :end_time, :integer
    add_column :shops, :business_time, :text
  end
end
