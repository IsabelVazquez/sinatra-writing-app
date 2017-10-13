class CreateListItems < ActiveRecord::Migration[5.1]
  def change
    create_table :list_items do |t|
      t.integer :word_number
      t.string :description
      t.integer :list_id
    end
  end
end
