# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subject, type: :model do
  context 'Subject validation' do
    it 'has valid factory' do
      expect(FactoryBot.build(:subject)).to be_valid
    end
    it 'is invalid without name' do
      expect(FactoryBot.build(:subject, name: nil)).to be_invalid
    end
  end
end
