module TransactionStateMachine

  def self.included(base)
    base.send(:include, AASM)
    
    base.send(:aasm, column: 'status') do
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
  end

  private

  def record_failed(type)
    failed = dup
    failed.parent_id = id
    failed.type = type
    failed.status = 'error'
    failed.save
  end
end
