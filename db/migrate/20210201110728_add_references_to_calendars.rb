class AddReferencesToCalendars < ActiveRecord::Migration[5.2]
  def change
    add_reference :calendars, :user, foreign_key: true
  end
end
