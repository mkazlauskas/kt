class AddReedMullerIdToStringMessage < ActiveRecord::Migration
  def change
    add_column :string_messages, :reed_muller_id, :integer
  end
end
