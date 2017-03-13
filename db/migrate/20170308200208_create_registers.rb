class CreateRegisters < ActiveRecord::Migration[5.0]
  def change
    create_table :registers do |t|
      t.integer :twenties, default: 0
      t.integer :tens, default: 0
      t.integer :fives, default: 0
      t.integer :twos, default: 0
      t.integer :ones, default: 0

      t.timestamps null: false
    end
  end
end
