require_relative '../../lib/json_web_token'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  extend Enumerize

  enumerize :status, in: [:admin, :author]

  def self.handle_login!(email, password)
    # Find User
    user = User.find_by(email: email.downcase)
    unless user.present?
      raise 'user not found!'
    end

    # Check password if user exists
    if user.valid_password?(password)
      user_info = Hash.new
      expires_at = Time.zone.now + 4.days
      user_info[:token] = JsonWebToken.encode({ user_id: user.id }, expires_at)
      user_info[:expires_at] = expires_at
      user_info[:user]  = user
      user_info
    else
      raise "wrong password!"
    end
  end
end
