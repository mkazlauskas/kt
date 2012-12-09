class RemoveBodyFromVector < ActiveRecord::Migration
  def change
    remove_column :binary_vectors, :body
  end
end