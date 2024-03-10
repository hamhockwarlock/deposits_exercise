class CreateTradelines < ActiveRecord::Migration[7.1]
  def change
    create_table :tradelines do |t|
      t.string :name, null: false
      t.decimal :amount, precision: 8, scale: 2, null: false

      t.timestamps
    end
  end
end
