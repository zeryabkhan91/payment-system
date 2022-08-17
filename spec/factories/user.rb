# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    status { 0 }

    trait :admin do
      role { 0 }
    end
  end
end
