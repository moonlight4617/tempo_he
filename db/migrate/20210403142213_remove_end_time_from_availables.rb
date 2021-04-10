class RemoveEndTimeFromAvailables < ActiveRecord::Migration[5.2]
  def change
    remove_column :availables, :end_time, :string
  end
end
