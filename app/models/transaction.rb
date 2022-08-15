# frozen_string_literal: true

class Transaction < ApplicationRecord
  include AASM

  belongs_to :user

  has_many :child_transactions, class_name: 'Transaction', foreign_key: :parent_id
  belongs_to :parent, class_name: 'Transaction', foreign_key: :parent_id, optional: true

  before_validation :set_uuid

  validates_presence_of :amount, :uuid, :customer_email, :status
  validates_uniqueness_of :uuid
  validates :customer_email, format: { with: Devise.email_regexp, message: 'Please enter valid email' }

  aasm column: 'status' do
    state :draft, initial: true
    state :approved
    state :reversed
    state :refunded
    state :error

    event :approve, after: :charge_transaction do
      error do |_e|
        record_failed('ChargeTransaction')
      end

      transitions from: :draft, to: :approved
    end

    event :refund, after: :refund_transaction do
      error do |_e|
        record_failed('RefundTransaction')
      end

      transitions from: :approved, to: :refunded
    end

    event :reverse, after: :reverse_transaction do
      error do |_e|
        record_failed('ReversalTransaction')
      end

      transitions from: :draft, to: :reversed
    end
  end

  private

  def set_uuid
    uuids = Transaction.pluck(:uuid)
    exist = true
    while exist
      self.uuid = SecureRandom.uuid
      exist = uuids.include?(uuid)
    end
  end

  def record_failed(type)
    failed = dup
    failed.parent_id = id
    failed.type = type
    failed.status = 'error'
    failed.save
    errors.add(:base, "#{type} can't")
  end
end
