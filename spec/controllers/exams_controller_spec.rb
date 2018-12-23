# frozen_string_literal: true

require 'rails_helper'
RSpec.describe ExamsController, type: :controller do
  before :each do
    @subject = FactoryBot.create(:subject)
    @questionset = FactoryBot.create(:questionset, subject_id: @subject.id)
    @user = FactoryBot.create(:user)
    test_sign_in(@user)
    @exam = FactoryBot.create(:exam, user_id: @user.id, questionset_id: @questionset.id)
  end
  context 'GET#index' do
    it 'has show all exams successfully' do
      exam1 = FactoryBot.create(:exam, user_id: @user.id, questionset_id: @questionset.id)
      exam2 = FactoryBot.create(:exam, user_id: @user.id, questionset_id: @questionset.id)
      get :index
      expect(assigns(:exams)).to include exam1
      expect(assigns(:exams)).to include exam2
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#show' do
    it 'has get exam successfully' do
      get :show, params: { id: @exam.id }
      expect(assigns(:exam)).to eq(@exam)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get invalid exam' do
      get :show, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end
  context 'GET#new' do
    it 'has get new exam successfully' do
      get :new
      expect(assigns(:exam).id).to eq(nil)
      expect(assigns(:exam).total_marks).to eq(nil)
      expect(assigns(:exam).attended_ques).to eq(nil)
      expect(assigns(:exam).questionset_id).to eq(nil)
      expect(assigns(:exam).user_id).to eq(nil)
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#edit' do
    it 'has get correct exam successfully' do
      get :edit, params: { id: @exam.id }
      expect(assigns(:exam)).to eq(@exam)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get exam with invalid id' do
      get :edit, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'has create exam successfully' do
      exam = FactoryBot.build(:exam, user_id: @user.id, questionset_id: @questionset.id)
      exam_params = {
        exam: {
          total_marks: exam.total_marks,
          attended_ques: exam.attended_ques,
          questionset_id: exam.questionset_id,
          user_id: exam.user_id
        }
      }
      post :create, params: exam_params
      expect(assigns(:exam).total_marks).to eq exam.total_marks
      expect(assigns(:exam).attended_ques).to eq exam.attended_ques
      expect(assigns(:exam).questionset_id).to eq exam.questionset_id
      expect(assigns(:exam).user_id).to eq exam.user_id
      expect(response).to have_http_status(:created)
    end

    it 'has not create exam with invalid inputs' do
      exam_params = {
        exam: {
          total_marks: nil,
          attended_ques: nil,
          questionset_id: nil,
          user_id: nil
        }
      }
      post :create, params: exam_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'has update exam successfully' do
      exam1 = FactoryBot.create(:exam, user_id: @user.id, questionset_id: @questionset.id)
      exam2 = FactoryBot.build(:exam, user_id: @user.id, questionset_id: @questionset.id)
      put :update,
          params: {
            id: exam1.id,
            exam: {
              total_marks: exam2.total_marks,
              attended_ques: exam2.attended_ques,
              questionset_id: exam2.questionset_id,
              user_id: exam2.user_id
            }
          }
      expect(assigns(:exam).id).to eq exam1.id
      expect(assigns(:exam).total_marks).to eq exam2.total_marks
      expect(assigns(:exam).attended_ques).to eq exam2.attended_ques
      expect(assigns(:exam).questionset_id).to eq exam2.questionset_id
      expect(assigns(:exam).user_id).to eq exam2.user_id
      expect(response).to have_http_status(:ok)
    end

    it 'has not update exam with invalid inputs' do
      exam1 = FactoryBot.create(:exam, user_id: @user.id, questionset_id: @questionset.id)
      put :update, params: {
        id: exam1.id, exam: {
          total_marks: nil,
          attended_ques: nil,
          questionset_id: nil,
          user_id: nil
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'has not update exam with invalid exam' do
      put :update, params: { id: '123456', exam: {
        total_marks: @exam.total_marks,
        attended_ques: @exam.attended_ques,
        questionset_id: @exam.questionset_id,
        user_id: @exam.user_id
      } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'has destroy exam successfully' do
      delete :destroy, params: { id: @exam.id }
      expect(assigns(:exam)).to eq @exam
      expect(response).to have_http_status(:ok)
    end

    it 'has not destroy invalid exam' do
      delete :destroy, params: { id: '12345' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
