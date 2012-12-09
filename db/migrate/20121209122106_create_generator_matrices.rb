class CreateGeneratorMatrices < ActiveRecord::Migration
  def change
    create_table :generator_matrices do |t|
      t.integer :rows
      t.integer :cols

      t.timestamps
    end
  end
end
