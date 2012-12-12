class RemoveStringMessageLengthLimit < ActiveRecord::Migration
  def change
    change_column :string_messages, :message, :text, :limit => nil
  end
end
