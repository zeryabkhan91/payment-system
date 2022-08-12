# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :user

  has_many :child_transactions, class_name: 'Transaction', foreign_key: :parent_id
  belongs_to :parent, class_name: 'Transaction', foreign_key: :parent_id

  validates_presence_of :amount, :uuid, :customer_email, :status
  validates_uniqueness_of :uuid
  validates :customer_email, format: { with: Devise.email_regexp, message: 'Please enter valid email' }
end
