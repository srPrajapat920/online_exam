# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :questionset
  validates :name, :option_a, :option_b, :option_c, :option_d, :ans,
            :ques_type, presence: true
  validates :ques_type, inclusion: { in: %w[easy medium hard] }
end
