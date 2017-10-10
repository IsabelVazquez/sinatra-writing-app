class CreateWriters < ActiveRecord::Migration[5.1]
  def change
    create_table :writers do |t|
      t.string :username
      t.string :email
      t.string :password
    end
  end
end
