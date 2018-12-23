# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, ques_type: :model do
  before :each do
    @subject = FactoryBot.create(:subject)
    @questionset = FactoryBot.create(:questionset, subject_id: @subject.id)
  end
  context 'Question validation' do
    it 'has valid factory' do
      expect(FactoryBot.build(:question, questionset_id: @questionset.id)).to be_valid
    end
    it 'is invalid without name' do
      expect(FactoryBot.build(:question, name: nil, questionset_id: @questionset.id)).to be_invalid
    end
    it 'is invalid without question id' do
      expect(FactoryBot.build(:question, questionset_id: nil)).to be_invalid
    end
    it 'is invalid without option_a' do
      expect(FactoryBot.build(:question, option_a: nil, questionset_id: @questionset.id)).to be_invalid
    end
    it 'is invalid without option_b' do
      expect(FactoryBot.build(:question, option_b: nil, questionset_id: @questionset.id)).to be_invalid
    end
    it 'is invalid without option_c' do
      expect(FactoryBot.build(:question, option_c: nil, questionset_id: @questionset.id)).to be_invalid
    end
    it 'is invalid without option_d' do
      expect(FactoryBot.build(:question, option_d: nil, questionset_id: @questionset.id)).to be_invalid
    end
    it 'is invalid without ans' do
      expect(FactoryBot.build(:question, ans: nil, questionset_id: @questionset.id)).to be_invalid
    end
    it 'is invalid without ques_type' do
      expect(FactoryBot.build(:question, ques_type: nil, questionset_id: @questionset.id)).to be_invalid
    end
  end
end
