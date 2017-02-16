class User < ApplicationRecord
  has_attached_file :current_upload_file
  validates_attachment_content_type :current_upload_file, content_type: ['application/msexcel', 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'text/plain']
  attr_accessor :password
  validates_confirmation_of :password
  before_save :encrypt_password

  def encrypt_password
    unless password.nil?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(email, password)
    user = User.where(email: email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end
