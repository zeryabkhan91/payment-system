class UserDecorator < ApplicationDecorator
  delegate_all

  def transactions_count
    transactions.count
  end
end
