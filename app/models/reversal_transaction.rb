class ReversalTransaction < Transaction
  belongs_to :authorize_transaction, foreign_key: :parent_id
end