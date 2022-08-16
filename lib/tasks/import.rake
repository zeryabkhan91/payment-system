# frozen_string_literal: true

require 'csv'

namespace :import do
  desc 'Import users from CSV'
  task users: :environment do
    file = File.read(Rails.root.join('users.csv'))
    users_data = CSV.parse(file, headers: true)
    users_data.each do |row|
      user = User.create(row.to_hash)
      next if user.errors.blank?

      puts "\nFailed for data: #{row}"
      puts "Reason: #{user.errors.full_messages}"
    end
  end
end
