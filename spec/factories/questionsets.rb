# frozen_string_literal: true

FactoryBot.define do
  factory :questionset do
    name { Faker::Name.name }
    time { Faker::Number.between(10, 120) }
    marks_per_ques { Faker::Number.between(3, 20) }
    is_active %w[true false].sample
    level %w[fresher intermediate experienced].sample
    no_ques { Faker::Number.between(5, 100) }
  end
end
