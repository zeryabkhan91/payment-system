class ChargeTransaction < Transaction
  belongs_to :authorize_transaction, foreign_key: :parent_id
  has_many :refund_transactions, foreign_key: :parent_id
end