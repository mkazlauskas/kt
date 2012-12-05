class CreateReedMullers < ActiveRecord::Migration
  def change
    create_table :reed_mullers do |t|
      t.integer :r
      t.integer :m

      t.timestamps
    end
  end
end
