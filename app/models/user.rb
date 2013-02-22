class User < ActiveRecord::Base

  has_and_belongs_to_many :ballots
  has_many :votes, dependent: :destroy
  
  ROLES = %w[administrator moderator voter]

  has_secure_password

  attr_accessible :email, :firstname, :lastname, :roles_mask, :password_digest, :password
  
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  before_save { |user| user.email = email.downcase }

  def voted_on? ballot
    ballot.votes.each do |v|
      return true if self.votes.include?(v)
    end
    return false
  end

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
