class CreateRegisters < ActiveRecord::Migration[5.0]
  def change
    create_table :registers do |t|
      t.integer :twenties, null: false
      t.integer :tens, null: false
      t.integer :fives, null: false
      t.integer :twos, null: false
      t.integer :ones, null: false

      t.timestamps null: false
    end
  end
end
