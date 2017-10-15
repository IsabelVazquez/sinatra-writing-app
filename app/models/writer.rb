class Writer < ActiveRecord::Base
  has_secure_password
  has_many :lists

  validates :username, presence: true
  validates :email, presence: true, format: { :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :password, presence: true
end
