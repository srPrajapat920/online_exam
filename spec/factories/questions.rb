# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    name { Faker::Name.name }
    option_a { Faker::Name.name }
    option_b { Faker::Name.name }
    option_c { Faker::Name.name }
    option_d { Faker::Name.name }
    ans { Faker::Name.name }
    is_active { Faker::Boolean.boolean }
    ques_type %w[easy medium hard].sample
  end
end
