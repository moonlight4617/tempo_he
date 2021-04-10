class ChangeDatatype < ActiveRecord::Migration[5.2]
  def change
    change_column :calendars, :start_time, :string
    change_column :calendars, :end_time, :string
    change_column :calendars, :rent_date, :string
    change_column :shops, :start_time, :string
    change_column :shops, :end_time, :string
  end
end
