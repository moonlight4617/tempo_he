class CreateTagToShops < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_to_shops do |t|
      t.references :tag, foreign_key: true
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
