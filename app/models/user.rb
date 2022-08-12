# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i[admin merchant]
  enum status: %i[active inactive]

  has_many :transactions

  before_validation :set_merchant_fields

  scope :merchants, -> { where(role: 'merchant') }

  def total_transactions
    self.transactions.count
  end

  private

  def set_merchant_fields
    self.password = Devise.friendly_token[0, 20] unless self.password
  end

end
