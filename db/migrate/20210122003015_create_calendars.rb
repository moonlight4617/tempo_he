class CreateCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :calendars do |t|
      t.time :start_time
      t.time :end_time
      t.date :rent_date
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
