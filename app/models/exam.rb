# frozen_string_literal: true

class Exam < ApplicationRecord
  belongs_to :user
  belongs_to :questionset
  validates :total_marks, :attended_ques, :questionset_id, :user_id, presence: true
  before_save :set_values

  private

  def set_values
    self.username = self.user.username
    self.email_id = self.user.email_id
    self.question_set = self.questionset.name
    self.start_at = Time.now.strftime('%d/%m/%Y')
  end
end
