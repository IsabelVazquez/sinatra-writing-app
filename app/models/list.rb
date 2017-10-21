class List < ActiveRecord::Base
  # to delete irrelevant list_items when a list is destroyed
  has_many :list_items, dependent: :destroy

  belongs_to :writer

  validates :title, :writer_id, presence: true
end
