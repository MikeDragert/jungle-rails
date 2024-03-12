class User < ApplicationRecord
  has_secure_password

  validates :password, length: {minimum: 3}, if: :password_digest_changed?
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password_digest, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by("LOWER(email) = ?", email.downcase.strip)
    if (user != nil)
      return user.authenticate(password)
    end
    return nil
  end
end
