class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.handle_login!(email, password)
    # Find User
    user = User.find_by(email: email.downcase)
    unless user.present?
      raise 'user not found!'
    end

    # Check password if user exists
    if user.valid_password?(password)
      unless user.confirmed?
        if user.status == 'pending'
          user.confirm
          # user.status = 'active'
          user.save(validate: false)
        else
          raise 'email confirmation error!'
        end

      end

      user_info = Hash.new
      # Generate User token
      expires_at = Time.zone.now + 4.days
      user_info[:token] = JsonWebToken.encode({ user_id: user.id }, expires_at)
      user_info[:expires_at] = expires_at
      serialized_user = UserSerializer.new(user).serializable_hash
      user_info[:user] = serialized_user[:data]
      user_info
    else
      raise "wrong password!"
    end
  end
end
