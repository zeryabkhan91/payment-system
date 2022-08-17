# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    amount { Faker::Number.between(from: 1, to: 10) }
    customer_email { Faker::Internet.email }
    customer_phone { '12345' }
    association :user, factory: :user
    type { 'AuthorizeTransaction' }
  end
end
