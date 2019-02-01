# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string
#  password_digest :string
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
    after_initialize :ensure_session_token
    validates :email, :session_token, presence: true, uniqueness: true
    validates :password, length:{minimum:8, allow_nil: true}
    
    
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def password
        @password
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)

        if user && user.is_password?(password)
            user
        else
            return nil
        end
    end

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def generate_session_token
           token = SecureRandom.urlsafe_base64(16)
    while self.class.exists?(session_token: token)
      token = SecureRandom.urlsafe_base64(16)
    end

    token
    end
    
    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end
    
end
