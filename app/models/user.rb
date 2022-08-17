# frozen_string_literal: true

class User < ApplicationRecord
  include UserAuth

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  enum role: %i[admin merchant]
  enum status: %i[active inactive]

  has_many :transactions, dependent: :restrict_with_error

  before_validation :set_merchant_fields

  scope :merchants, -> { where(role: 'merchant') }

  private

  def set_merchant_fields
    self.password = Devise.friendly_token[0, 20] if password.blank?
  end
end
