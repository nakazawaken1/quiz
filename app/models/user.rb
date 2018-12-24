class User < ApplicationRecord
    has_secure_password validations: true
    validates :name, presence: true   
    validates :mail, presence: true, uniqueness: true
end
