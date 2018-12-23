# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email_id { Faker::Internet.email }
    password { Faker::Internet.password(6, 10) }
    contact_no { Faker::Number.number(10) }
    level %w[fresher intermediate experienced].sample
    admin %w[true false].sample
  end
end
