class RemoveFavoriteFromEvaluations < ActiveRecord::Migration[5.2]
  def change
    remove_column :evaluations, :favorite, :integer
  end
end
