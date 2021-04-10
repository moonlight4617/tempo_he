class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :fin_flg
      t.integer :del_flg
      t.references :chat, foreign_key: true

      t.timestamps
    end
  end
end
