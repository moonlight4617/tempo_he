class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :prefecture
      t.string :city
      t.string :address
      t.integer :tel
      t.string :station
      t.integer :capacity
      t.string :image
      t.integer :price
      t.text :content
      t.integer :del_flg
      t.integer :owner_id

      t.timestamps
    end
  end
end
