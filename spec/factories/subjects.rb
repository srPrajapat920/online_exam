# frozen_string_literal: true

FactoryBot.define do
  factory :subject do
    name { Faker::Name.name }
  end
end
