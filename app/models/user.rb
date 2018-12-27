class User < ApplicationRecord
    has_secure_password validations: true
    validates :name, presence: true   
    validates :mail, presence: true, uniqueness: true
    def self.encrypt(text)
        Digest::SHA256.hexdigest(text.to_s)
    end
end
