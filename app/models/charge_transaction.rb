# frozen_string_literal: true

class ChargeTransaction < Transaction
  belongs_to :authorize_transaction, foreign_key: :parent_id
  has_many :refund_transactions, foreign_key: :parent_id

  def refund_transaction
    refunded = dup
    refunded.parent_id = id
    refunded.type = 'RefundTransaction'
    refunded.save
  end
end
