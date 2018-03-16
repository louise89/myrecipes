class Chef < ApplicationRecord
  before_save {self.email = email.downcase}
  validates :chefname, presence: true, length: {minimum: 5, maximum: 50}
  validates :email, presence: true, length: {minimum: 5, maximum: 50},
            uniqueness: true,
            format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
                    message: "Invalid format for email address"}
    has_many :recipes
    has_secure_password
    validates :password, presence: true, length: {minimum: 5, maximum: 50}
end
