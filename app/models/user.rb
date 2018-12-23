# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :password
  has_many :exam
  validates :username, :email_id, :contact_no, :password, :level, presence: true
  validates :email_id, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :level, inclusion: { in: %w[fresher intermediate experienced] }
  validates :email_id, uniqueness: true
  validates :contact_no, length: { is: 10 }, numericality: { only_integer: true }
  validates :password, length: { in: 6..10 }
  before_save :valid_email_id
  before_save :encrypt_password

  def self.authenticate(email_id, password)
    user = find_by_email_id(email_id)
    return nil if user.nil?
    return user if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  private

  def valid_email_id
    email_id.downcase
  end
end
