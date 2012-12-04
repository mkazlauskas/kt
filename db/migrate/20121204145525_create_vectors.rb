class CreateVectors < ActiveRecord::Migration
  def change
    create_table :vectors do |t|
      t.string :body
      t.string :elements
      t.integer :length

      t.timestamps
    end
  end
end
