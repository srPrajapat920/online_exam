# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exam, type: :model do
  before :each do
    @subject = FactoryBot.create(:subject)
    @questionset = FactoryBot.create(:questionset, subject_id: @subject.id)
    @user = FactoryBot.create(:user)
  end
  context 'User validation' do
    it 'has valid factory' do
      expect(FactoryBot.build(:exam, questionset_id: @questionset.id, user_id: @user.id)).to be_valid
    end
    it 'is invalid without total marks' do
      expect(FactoryBot.build(:exam, total_marks: nil, questionset_id: @questionset.id, user_id: @user.id)).to be_invalid
    end
    it 'is invalid without no of attended questions' do
      expect(FactoryBot.build(:exam, attended_ques: nil, questionset_id: @questionset.id, user_id: @user.id)).to be_invalid
    end
    it 'set values before save' do
      @exam = FactoryBot.create(:exam,user_id:@user.id,questionset_id:@questionset.id)
      expect(@exam.username).to eq(@user.username)
      expect(@exam.email_id).to eq(@user.email_id)
      expect(@exam.question_set).to eq(@questionset.name)
      expect(@exam.start_at).to eq(Time.now.strftime('%d/%m/%Y'))
    end
  end
end
