class RenameVectorLengthToSize < ActiveRecord::Migration
  def change
    rename_column :vectors, :length, :size
  end
end
