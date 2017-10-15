class List < ActiveRecord::Base
  has_many :list_items
  belongs_to :writer

  validates :title, presence: true
  validates :writer_id, presence: true
end
