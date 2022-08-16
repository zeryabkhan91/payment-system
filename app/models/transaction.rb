# frozen_string_literal: true

class Transaction < ApplicationRecord
  include TransactionStateMachine

  belongs_to :user

  validates_presence_of :amount, :customer_email, :status
  validates :amount, numericality: { greater_than: 0 }
  validates :customer_email, format: { with: Devise.email_regexp, message: 'Please enter valid email' }
  validate :active_user

  private

  def active_user
    if self.user.inactive?
      errors.add("Can't create Transaction for Inactive Merchant")
    end
  end
end
