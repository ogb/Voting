class User < ActiveRecord::Base
  
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  ROLES = %w[voter moderator administrator]

  has_secure_password

  attr_accessible :email, :firstname, :lastname, :roles_mask, :password_digest, :password
  
  validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  before_save { |user| user.email = email.downcase }


end
