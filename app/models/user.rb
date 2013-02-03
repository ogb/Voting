class User < ActiveRecord::Base

  has_and_belongs_to_many :ballots
  
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  ROLES = %w[voter moderator administrator]

  has_secure_password

  attr_accessible :email, :firstname, :lastname, :roles_mask, :password_digest, :password
  
  validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  
  before_save { |user| user.email = email.downcase }
  
  



  # use a bitmask to store the roles
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end
  
  def is?(role)
    roles.include?(role.to_s)
  end

end
