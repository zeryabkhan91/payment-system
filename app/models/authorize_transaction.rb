# frozen_string_literal: true

class AuthorizeTransaction < Transaction
  has_many :charge_transactions, foreign_key: :parent_id
  has_many :reversal_transactions, foreign_key: :parent_id

  def charge_transaction
    duplicate('ChargeTransaction')
  end

  def reverse_transaction
    duplicate('ReversalTransaction')
  end

  private

  def duplicate(type)
    transaction = dup
    transaction.parent_id = id
    transaction.type = type
    transaction.save
  end
end
