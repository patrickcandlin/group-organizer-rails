class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :email, presence: true, length: { maximum: 250 }
    validates :email, uniqueness: true
end