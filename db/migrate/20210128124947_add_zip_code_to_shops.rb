class AddZipCodeToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :zip_code, :integer
  end
end
