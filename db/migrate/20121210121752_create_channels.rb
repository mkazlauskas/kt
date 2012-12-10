class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :reliability
      t.integer :reed_muller_id
      t.timestamps
    end
  end
end
