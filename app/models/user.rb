# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  enum role: %i[admin merchant]
  enum status: %i[active inactive]

  has_many :transactions, dependent: :restrict_with_error

  before_validation :set_merchant_fields

  scope :merchants, -> { where(role: 'merchant') }

  def total_transactions
    transactions.count
  end

  private

  def set_merchant_fields
    self.password = Devise.friendly_token[0, 20] unless password
  end
end
