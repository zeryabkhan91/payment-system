# frozen_string_literal: true

class UpdateTransaction
  include Interactor

  VALID_ACTIONS = %i[approve refund reverse].freeze

  ACTIONS_ADAPTERS = {
    'approve' => 'approved',
    'refund' => 'refunded',
    'reverse' => 'reversed'
  }.freeze

  def call
    transaction = Transaction.find_by(id: context.id)

    context.fail!(error: 'Transaction not found') if transaction.blank?
    context.fail!(error: 'Invalid action') unless VALID_ACTIONS.include?(context.state.to_sym)

    if transaction.send("#{context.state}!")
      context.message = "Transaction #{ACTIONS_ADAPTERS[context.state]} successfully"
    else
      context.fail!(error: "Transaction can't be #{ACTIONS_ADAPTERS[context.state]}")
    end
  end
end
