# frozen_string_literal: true

module Api
  class TransactionsController < Api::BaseController
    def create
      @transaction = Transaction.new(transaction_params)
      @transaction.user = current_user unless @transaction.user_id
      if @transaction.save
        render json: @transaction
      else
        render json: { error: @transaction.errors.full_messages }, status: 422
      end
    end

    def index
      render json: { user: current_user, transactions: Transaction.all }
    end

    def update
      result = ::UpdateTransaction.call(state_params)
      if result.success?
        render json: { message: result.message }
      else
        render json: { error: result.error }, status: 422
      end
    end

    private

    def transaction_params
      params.require(:transaction).permit(:amount, :customer_phone, :customer_email, :user_id)
    end

    def state_params
      params.permit(:id, :state)
    end
  end
end
