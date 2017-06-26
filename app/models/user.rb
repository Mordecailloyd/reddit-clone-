# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :text             not null
#  session_token   :text             not null
#  password_digest :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :session_token, presence: true
  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token
  attr_reader :password


  has_many :posts,
  primary_key: :id,
  foreign_key: :author_id,
  class_name: :Post

  has_many :subs,
  primary_key: :id,
  foreign_key: :moderator_id,
  class_name: :Sub


  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user =  User.find_by_username(username)
    if user.nil?
      return nil
    end
    user.is_password?(password) ? user : nil
  end

  def reset_session_token
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end

  private
  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end


end
