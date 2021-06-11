class AddColumnToshopToEvaluation < ActiveRecord::Migration[5.2]
  def change
    add_column :evaluations, :toshop, :integer
  end
end
