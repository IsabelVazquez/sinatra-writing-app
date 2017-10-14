class RenameUserIdToWriterId < ActiveRecord::Migration[5.1]
  def change
    rename_column :lists, :user_id, :writer_id
  end
end
