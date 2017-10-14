class AddTitleToLists < ActiveRecord::Migration[5.1]
  def change
    add_column :lists, :title, :string
  end
end
