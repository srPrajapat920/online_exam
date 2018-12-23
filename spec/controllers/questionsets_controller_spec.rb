# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionsetsController, type: :controller do
  before :each do
    @user = FactoryBot.create(:user)
    test_sign_in(@user)
    @subject = FactoryBot.create(:subject)
    @questionset = FactoryBot.create(:questionset, subject_id: @subject.id)
  end
  context 'GET#index' do
    it 'has show all questionsetes successfully' do
      questionset1 = FactoryBot.create(:questionset, subject_id: @subject.id)
      questionset2 = FactoryBot.create(:questionset, subject_id: @subject.id)
      get :index
      expect(assigns(:questionsets)).to include questionset1
      expect(assigns(:questionsets)).to include questionset2
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#show' do
    it 'has get questionset successfully' do
      get :show, params: { id: @questionset.id }
      expect(assigns(:questionset)).to eq(@questionset)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get invalid questionset' do
      get :show, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end
  context 'GET#new' do
    it 'has get new questionset successfully' do
      get :new
      expect(assigns(:questionset).id).to eq(nil)
      expect(assigns(:questionset).name).to eq(nil)
      expect(assigns(:questionset).time).to eq(nil)
      expect(assigns(:questionset).marks_per_ques).to eq(nil)
      expect(assigns(:questionset).no_ques).to eq(nil)
      expect(assigns(:questionset).level).to eq(nil)
      expect(assigns(:questionset).subject_id).to eq(nil)
      expect(assigns(:questionset).is_active).to eq(nil)
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#edit' do
    it 'has get correct questionset successfully' do
      get :edit, params: { id: @questionset.id }
      expect(assigns(:questionset)).to eq(@questionset)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get questionset with invalid id' do
      get :edit, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'has create questionset successfully' do
      questionset = FactoryBot.build(:questionset, subject_id: @subject.id)
      questionset_params = {
        questionset: {
          name: questionset.name,
          time: questionset.time,
          marks_per_ques: questionset.marks_per_ques,
          no_ques: questionset.no_ques,
          level: questionset.level,
          is_active: questionset.is_active,
          subject_id: questionset.subject_id
        }
      }
      post :create, params: questionset_params
      expect(assigns(:questionset).name).to eq questionset.name
      expect(assigns(:questionset).time).to eq questionset.time
      expect(assigns(:questionset).marks_per_ques).to eq questionset.marks_per_ques
      expect(assigns(:questionset).no_ques).to eq questionset.no_ques
      expect(assigns(:questionset).level).to eq questionset.level
      expect(assigns(:questionset).is_active).to eq questionset.is_active
      expect(assigns(:questionset).subject_id).to eq questionset.subject_id
      expect(response).to have_http_status(:created)
    end

    it 'has not create questionset with invalid inputs' do
      questionset_params = {
        questionset: { name: nil, time: nil, marks_per_ques: nil, no_ques: nil,
                       level: nil, is_active: nil, subject_id: nil }
      }
      post :create, params: questionset_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'has update questionset successfully' do
      questionset1 = FactoryBot.create(:questionset, subject_id: @subject.id)
      questionset2 = FactoryBot.build(:questionset, subject_id: @subject.id)
      put :update,
          params: {
            id: questionset1.id,
            questionset: {
              name: questionset2.name,
              time: questionset2.time,
              marks_per_ques: questionset2.marks_per_ques,
              level: questionset2.level,
              no_ques: questionset2.no_ques,
              is_active: questionset2.is_active,
              subject_id: questionset2.subject_id
            }
          }
      expect(assigns(:questionset).id).to eq questionset1.id
      expect(assigns(:questionset).name).to eq questionset2.name
      expect(assigns(:questionset).time).to eq questionset2.time
      expect(assigns(:questionset).marks_per_ques).to eq questionset2.marks_per_ques
      expect(assigns(:questionset).no_ques).to eq questionset2.no_ques
      expect(assigns(:questionset).level).to eq questionset2.level
      expect(assigns(:questionset).is_active).to eq questionset2.is_active
      expect(assigns(:questionset).subject_id).to eq questionset2.subject_id
      expect(response).to have_http_status(:ok)
    end

    it 'has not update questionset with invalid inputs' do
      questionset1 = FactoryBot.create(:questionset, subject_id: @subject.id)
      put :update, params: {
        id: questionset1.id, questionset: {
          name: nil, time: nil, marks_per_ques: nil, no_ques: nil, level: nil, is_active: nil
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'has not update questionset with invalid questionset' do
      put :update, params: { id: '123456', questionset: {
        name: @questionset.name,
        time: @questionset.time,
        marks_per_ques: @questionset.marks_per_ques,
        no_ques: @questionset.no_ques,
        level: @questionset.level,
        is_active: @questionset.is_active,
        subject_id:  @subject.id
      } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'has destroy questionset successfully' do
      delete :destroy, params: { id: @questionset.id }
      expect(assigns(:questionset)).to eq @questionset
      expect(response).to have_http_status(:ok)
    end

    it 'has not destroy invalid questionset' do
      delete :destroy, params: { id: '12345' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
