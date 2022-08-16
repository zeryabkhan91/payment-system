# frozen_string_literal: true

require 'csv'

namespace :remove do
  desc 'Remove old transactions'
  task old_transactions: :environment do
    Transaction.where('updated_at < ?', 1.hour.ago).destroy_all
  end
end
