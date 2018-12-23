# frozen_string_literal: true

FactoryBot.define do
  factory :exam do
    total_marks { Faker::Number.between(0, 200) }
    attended_ques { Faker::Number.between(0, 100) }
  end
end
