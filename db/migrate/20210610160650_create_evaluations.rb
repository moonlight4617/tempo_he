class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.integer :favorite
      t.text :comment
      t.integer :rate
      t.references :user
      t.references :shop

      t.timestamps
    end
  end
end
