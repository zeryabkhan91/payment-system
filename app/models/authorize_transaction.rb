# frozen_string_literal: true

class AuthorizeTransaction < Transaction
  has_many :charge_transactions, foreign_key: :parent_id
  has_many :reversal_transactions, foreign_key: :parent_id
end
