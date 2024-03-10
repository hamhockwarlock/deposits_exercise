class CreateDeposits < ActiveRecord::Migration[7.1]
  def change
    create_table :deposits do |t|
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.datetime :transaction_time, null: false
      t.references :tradelines, index: true, null: false, foreign_key: true

      t.timestamps
    end
  end
end
