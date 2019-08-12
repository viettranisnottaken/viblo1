class User < ApplicationRecord
  has_many :requests

  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 100}
  validates :email, presence: true, length: {maximum: 250},
                    format: {with: EMAIL_FORMAT}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}
end
