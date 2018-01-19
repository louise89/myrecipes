class Chef < ApplicationRecord
validates :chefname, presence: true, length: {minimum: 5, maximum: 50}
validates :email, presence: true, length: {minimum: 5, maximum: 50},
          uniqueness: true,
          format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
                  message: "Invalid format for email address"}
end
