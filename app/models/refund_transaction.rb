class RefundTransaction < Transaction
  belongs_to :charge_transaction, foreign_key: :parent_id 
end