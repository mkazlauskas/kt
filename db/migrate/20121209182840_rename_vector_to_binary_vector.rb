class RenameVectorToBinaryVector < ActiveRecord::Migration
  def change
    rename_table :vectors, :binary_vectors
  end
end
