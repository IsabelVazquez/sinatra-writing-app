class AddPasswordDigest < ActiveRecord::Migration[5.1]
  def change
    rename_column :writers, :password, :password_digest
  end
end
