# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionsController, ques_type: :controller do
  before :each do
    @user = FactoryBot.create(:user)
    @subject = FactoryBot.create(:subject)
    @questionset = FactoryBot.create(:questionset, subject_id: @subject.id)
    @question = FactoryBot.create(:question, questionset_id: @questionset.id)
    test_sign_in(@user)
  end
  context 'GET#index' do
    it 'has show all questions successfully' do
      question1 = FactoryBot.create(:question, questionset_id: @questionset.id)
      question2 = FactoryBot.create(:question, questionset_id: @questionset.id)
      get :index
      expect(assigns(:questions)).to include question1
      expect(assigns(:questions)).to include question2
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#show' do
    it 'has get question successfully' do
      get :show, params: { id: @question.id }
      expect(assigns(:question)).to eq(@question)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get invalid question' do
      get :show, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end
  context 'GET#new' do
    it 'has get new question successfully' do
      get :new
      expect(assigns(:question).id).to eq(nil)
      expect(assigns(:question).name).to eq(nil)
      expect(assigns(:question).option_a).to eq(nil)
      expect(assigns(:question).option_b).to eq(nil)
      expect(assigns(:question).option_c).to eq(nil)
      expect(assigns(:question).option_d).to eq(nil)
      expect(assigns(:question).ans).to eq(nil)
      expect(assigns(:question).ques_type).to eq(nil)
      expect(assigns(:question).is_active).to eq(nil)
      expect(assigns(:question).questionset_id).to eq(nil)
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#edit' do
    it 'has get correct question successfully' do
      get :edit, params: { id: @question.id }
      expect(assigns(:question)).to eq(@question)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get question with invalid id' do
      get :edit, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'has create question successfully' do
      question = FactoryBot.build(:question, questionset_id: @questionset.id)
      question_params = {
        question: {
          name: question.name,
          option_a: question.option_a,
          option_b: question.option_b,
          option_c: question.option_c,
          option_d: question.option_d,
          ans: question.ans,
          ques_type: question.ques_type,
          is_active: question.is_active,
          questionset_id: question.questionset_id
        }
      }
      post :create, params: question_params
      expect(assigns(:question).name).to eq question.name
      expect(assigns(:question).option_a).to eq question.option_a
      expect(assigns(:question).option_b).to eq question.option_b
      expect(assigns(:question).option_c).to eq question.option_c
      expect(assigns(:question).option_d).to eq question.option_d
      expect(assigns(:question).ans).to eq question.ans
      expect(assigns(:question).ques_type).to eq question.ques_type
      expect(assigns(:question).is_active).to eq question.is_active
      expect(assigns(:question).questionset_id).to eq question.questionset_id
      expect(response).to have_http_status(:created)
    end

    it 'has not create question with invalid inputs' do
      question_params = {
        question: {
          name: nil,
          option_a: nil,
          option_b: nil,
          option_c: nil,
          option_d: nil,
          ans: nil,
          ques_type: nil,
          is_active: nil,
          questionset_id: nil
        }
      }
      post :create, params: question_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'has update question successfully' do
      question1 = FactoryBot.create(:question, questionset_id: @questionset.id)
      question2 = FactoryBot.build(:question, questionset_id: @questionset.id)
      put :update,
          params: {
            id: question1.id,
            question: {
              name: question2.name,
              option_a: question2.option_a,
              option_b: question2.option_b,
              option_c: question2.option_c,
              option_d: question2.option_d,
              ans: question2.ans,
              ques_type: question2.ques_type,
              is_active: question2.is_active,
              questionset_id: question2.questionset_id
            }
          }
      expect(assigns(:question).id).to eq question1.id
      expect(assigns(:question).name).to eq question2.name
      expect(assigns(:question).option_a).to eq question2.option_a
      expect(assigns(:question).option_b).to eq question2.option_b
      expect(assigns(:question).option_c).to eq question2.option_c
      expect(assigns(:question).option_d).to eq question2.option_d
      expect(assigns(:question).ans).to eq question2.ans
      expect(assigns(:question).ques_type).to eq question2.ques_type
      expect(assigns(:question).is_active).to eq question2.is_active
      expect(assigns(:question).questionset_id).to eq question2.questionset_id
      expect(response).to have_http_status(:ok)
    end

    it 'has not update question with invalid inputs' do
      question1 = FactoryBot.create(:question, questionset_id: @questionset.id)
      put :update, params: {
        id: question1.id, question: {
          name: nil,
          option_a: nil,
          option_b: nil,
          option_c: nil,
          option_d: nil,
          ans: nil,
          ques_type: nil,
          is_active: nil,
          questionset_id: nil
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'has not update question with invalid question' do
      put :update, params: { id: '123456', question: {
        name: @question.name,
        option_a: @question.option_a,
        option_b: @question.option_b,
        option_c: @question.option_c,
        option_d: @question.option_d,
        ans: @question.ans,
        ques_type: @question.ques_type,
        is_active: @question.is_active,
        questionset_id: @question.questionset_id
      } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'has destroy question successfully' do
      delete :destroy, params: { id: @question.id }
      expect(assigns(:question)).to eq @question
      expect(response).to have_http_status(:ok)
    end

    it 'has not destroy invalid question' do
      delete :destroy, params: { id: '12345' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
