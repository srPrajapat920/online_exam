# frozen_string_literal: true

require 'rails_helper'
require 'application_controller'
RSpec.describe SessionsController, type: :controller do
  before :each do
    @user = FactoryBot.create(:user)
    @session = { session: { email_id: @user.email_id, password: @user.password } }
  end
  context 'GET#new' do
    it 'has get new session successfully' do
      get :new
      expect(response).to have_http_status(:ok)
    end
  end

  context 'POST#create' do
    it 'has sign the user in' do
      post :create, params: @session, format: 'json'
      test_sign_in(@user)
      expect(request.session[:user_id]).not_to be_nil
    end
    it 'has redirect to the user show page' do
      post :create, params: @session, format: 'json'
      test_sign_in(@user)
      expect(response).to redirect_to(subjects_path)
    end
    it 'has redirect to the login page' do
      @session2 = { session: { email_id: 'sanjy111@gmail.com', password: 'wrongpasswoed' } }
      post :create, params: @session2, format: 'json'
      expect(flash[:danger]).to eq('Invalid email/password combination')
      expect(response).to redirect_to(login_path)
    end
  end

  context "DELETE 'destroy'" do
    it 'has sign a user out' do
      @user = FactoryBot.create(:user)
      test_sign_in(@user)
      delete :destroy
      not_logged_in
      expect(response).to redirect_to(login_path)
    end
  end
end
