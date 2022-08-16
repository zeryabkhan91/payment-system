# frozen_string_literal: true

module Api
  class TransactionsController < Api::BaseController
    before_action :set_transaction, except: %i[create index]

    def create
      @transaction = Transaction.new(transaction_params)
      @transaction.user = current_user unless @transaction.user_id
      if @transaction.save
        render json: @transaction
      else
        render json: @transaction.errors.full_messages, status: 422
      end
    end

    def index
      render json: { user: current_user, transactions: Transaction.all }
    end

    def update
      if @transaction.update(transaction_params)
        render json: @transaction
      else
        render json: @transaction.errors.full_messages, status: 422
      end
    end

    def approve
      if @transaction.approve!
        render json: { message: 'Transaction Approved' }
      else
        render json: { message: "#{@transaction.class} can't Approved." }
      end
    end

    def refund
      if @transaction.refund!
        render json: { message: 'Transaction Refunded' }
      else
        render json: { message: "#{@transaction.class} can't be Refunded." }
      end
    end

    def reverse
      if @transaction.reverse!
        render json: { message: 'Transaction Reversed' }
      else
        render json: { message: "#{@transaction.class} can't be Reversed." }
      end
    end

    private

    def transaction_params
      params.require(:transaction).permit(:name, :amount, :customer_name, :customer_email, :user_id)
    end

    def set_transaction
      @transaction = Transaction.find_by(id: params[:id])
    end
  end
end
