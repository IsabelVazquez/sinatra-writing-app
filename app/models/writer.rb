class Writer < ActiveRecord::Base
  has_secure_password
  has_many :lists

  validates :username, :email, uniqueness: true
  validates :username, :email, presence: true
  validates :email, format: { :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
end
