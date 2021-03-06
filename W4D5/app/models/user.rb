class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, length: {minimum: 5, allow_nil: true}
  validates :password_digest, presence: true
  validates :session_token, presence: true, uniqueness: true
  
  after_initialize :ensure_session_token
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
  
  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end
  
  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end
  
  attr_reader :password
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
     BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil unless user
    user.is_password?(password) ? user : nil
  end
end
