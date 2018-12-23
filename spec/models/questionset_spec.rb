# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Questionset, type: :model do
  before :each do
    @subject = FactoryBot.create(:subject)
  end
  context 'Questionset validation' do
    it 'has valid factory' do
      expect(FactoryBot.build(:questionset, subject_id: @subject.id)).to be_valid
    end
    it 'is invalid without name' do
      expect(FactoryBot.build(:questionset, name: nil, subject_id: @subject.id)).to be_invalid
    end
    it 'is invalid without subject_id' do
      expect(FactoryBot.build(:questionset, subject_id: nil)).to be_invalid
    end
    it 'is invalid without time' do
      expect(FactoryBot.build(:questionset, time: nil, subject_id: @subject.id)).to be_invalid
    end
    it 'is invalid without level' do
      expect(FactoryBot.build(:questionset, level: nil, subject_id: @subject.id)).to be_invalid
    end
    it 'is invalid without marks per question' do
      expect(FactoryBot.build(:questionset, marks_per_ques: nil, subject_id: @subject.id)).to be_invalid
    end
    it 'is invalid without no of questions' do
      expect(FactoryBot.build(:questionset, no_ques: nil, subject_id: @subject.id)).to be_invalid
    end
    it 'taks only integer value of time' do
      expect(FactoryBot.build(:questionset, time: '3hr', subject_id: @subject.id)).to be_invalid
    end
    it 'taks only integer value of marks per question' do
      expect(FactoryBot.build(:questionset, marks_per_ques: 'five', subject_id: @subject.id)).to be_invalid
    end
    it 'taks only integer value of no of question' do
      expect(FactoryBot.build(:questionset, no_ques: 'ten', subject_id: @subject.id)).to be_invalid
    end
    it 'is invalid to has zero value of marks per question' do
      expect(FactoryBot.build(:questionset, marks_per_ques: '0', subject_id: @subject.id)).to be_invalid
    end
    it 'is invalid to has less then zero value of marks_per_ques' do
      expect(FactoryBot.build(:questionset, marks_per_ques: '-5', subject_id: @subject.id)).to be_invalid
    end
    it 'is invalid to has zero value of no of question' do
      expect(FactoryBot.build(:questionset, no_ques: '0', subject_id: @subject.id)).to be_invalid
    end
    it 'is invalid to has less then zero value of no_of_question' do
      expect(FactoryBot.build(:questionset, no_ques: '-5', subject_id: @subject.id)).to be_invalid
    end
    it 'is invalid to has zero value of time' do
      expect(FactoryBot.build(:questionset, time: '0', subject_id: @subject.id)).to be_invalid
    end
    it 'is invalid to has less then zero value of marks_per_ques' do
      expect(FactoryBot.build(:questionset, time: '-5', subject_id: @subject.id)).to be_invalid
    end
  end
end
