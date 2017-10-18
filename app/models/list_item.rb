class ListItem < ActiveRecord::Base
  belongs_to :list
  validates :word_number, :description, presence: true
end
