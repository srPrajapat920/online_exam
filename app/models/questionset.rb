# frozen_string_literal: true

class Questionset < ApplicationRecord
  belongs_to :subject
  has_many :question, dependent: :destroy
  has_many :exam
  has_many :user, through: :exam
  validates :name, :level, :subject_id, presence: true
  validates :time, :marks_per_ques, :no_ques, numericality: { only_integer: true }
  validates :level, inclusion: { in: %w[fresher intermediate experienced] }
  validate :valid_marks_per_ques
  validate :valid_time
  validate :valid_no_ques

  private

  def valid_marks_per_ques
    errors.add(:marks_per_ques, 'invailid marks per question') if marks_per_ques.nil? || marks_per_ques <= 0
  end

  def valid_time
    errors.add(:time, 'invailid time') if time.nil? ||  time <= 0
  end

  def valid_no_ques
    errors.add(:no_ques, 'invailid no of questions') if no_ques.nil? || no_ques <= 0
  end
end
