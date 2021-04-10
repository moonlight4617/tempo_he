class CreateOwners < ActiveRecord::Migration[5.2]
  def change
    create_table :owners do |t|
      t.string :name
      t.string :address
      t.integer :tel
      t.string :email
      t.string :password_digest
      t.integer :del_flg

      t.timestamps
    end
  end
end
