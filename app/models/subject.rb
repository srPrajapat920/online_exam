# frozen_string_literal: true

# Description/Explanation of subject class
class Subject < ApplicationRecord
  has_many :questionset, dependent: :destroy
  validates :name, presence: true
end
