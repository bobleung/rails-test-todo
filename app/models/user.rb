class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  # Ensure email is present, unique, and in a valid format
  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Validate presence of first name and last name
  validates :first_name, presence: true
  validates :last_name, presence: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
