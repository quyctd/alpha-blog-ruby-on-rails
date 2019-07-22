# frozen_string_literal: true

# User class using for user account
class User < ActiveRecord::Base
  has_many :articles
  before_save { self.email = email.downcase }
  validates :username, length: { minimum: 3, maximum: 25 },
                       uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, length: { minimum: 3, maximum: 25 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }
  validates_presence_of :username, :email
end
