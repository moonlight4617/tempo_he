class CreateAvailables < ActiveRecord::Migration[5.2]
  def change
    create_table :availables do |t|
      t.string :rent_date
      t.string :start_time
      t.string :end_time
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
