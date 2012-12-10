class AddVectorToReedMuller < ActiveRecord::Migration
  def change
    add_column :binary_vectors, :reed_muller_id, :integer
  end
end
