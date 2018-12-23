# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  before :each do
    @user = FactoryBot.create(:user)
    test_sign_in(@user)
    @subject = FactoryBot.create(:subject)
  end
  context 'GET#index' do
    it 'has show all subjects successfully' do
      subject1 = FactoryBot.create(:subject)
      subject2 = FactoryBot.create(:subject)
      get :index
      expect(assigns(:subjects)).to include subject1
      expect(assigns(:subjects)).to include subject2
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#show' do
    it 'has get subject successfully' do
      get :show, params: { id: @subject.id }
      expect(assigns(:subject)).to eq(@subject)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get invalid subject' do
      get :show, params: { id: '12345' }, format: 'json'
      expect(response).to have_http_status(:not_found)
    end
  end
  context 'GET#new' do
    it 'has get new subject successfully' do
      get :new
      expect(assigns(:subject).id).to eq(nil)
      expect(assigns(:subject).name).to eq(nil)
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#edit' do
    it 'has get correct subject successfully' do
      get :edit, params: { id: @subject.id }
      expect(assigns(:subject)).to eq(@subject)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get subject with invalid id' do
      get :edit, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'has create subject successfully' do
      subject_params = {
        subject: {
          name: @subject.name
        }
      }
      post :create, params: subject_params, format: 'json'
      expect(assigns(:subject).name).to eq @subject.name
      expect(response).to have_http_status(:created)
    end

    it 'has not create subject with invalid inputs' do
      subject_params = {
        subject: {
          name: nil
        }
      }
      post :create, params: subject_params, format: 'json'
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'has update subject successfully' do
      subject1 = FactoryBot.create(:subject)
      subject2 = FactoryBot.build(:subject)
      put :update,
          params: {
            id: subject1.id,
            subject: {
              name: subject2.name
            }
          }
      expect(assigns(:subject).id).to eq subject1.id
      expect(assigns(:subject).name).to eq subject2.name
      expect(response).to have_http_status(:ok)
    end

    it 'has not update subject with invalid inputs' do
      subject1 = FactoryBot.create(:subject)
      put :update, params: {
        id: subject1.id, subject: {
          name: nil
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'has not update subject with invalid subject' do
      put :update, params: { id: '123456', subject: {
        name: @subject.name
      } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'has destroy subject successfully' do
      delete :destroy, params: { id: @subject.id }
      expect(assigns(:subject)).to eq @subject
      expect(response).to have_http_status(:ok)
    end

    it 'has not destroy invalid subject' do
      delete :destroy, params: { id: '12345' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
