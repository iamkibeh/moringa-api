class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    # validates :password, length: {minimum: 4, maximum: 20}
    validates :user_type, inclusion: {in: %w(user company)}, presence: true
end
