class ListItem < ActiveRecord::Base
  belongs_to :list

  validates :word_number, :description, presence: true
  validates :word_number, numericality: { only_integer: true }
end
