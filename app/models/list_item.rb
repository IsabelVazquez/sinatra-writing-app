class ListItem < ActiveRecord::Base
  belongs_to :list
  validates :word_number, presence: true
  validates :description, presence: true
end
