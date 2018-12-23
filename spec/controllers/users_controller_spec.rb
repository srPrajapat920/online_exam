# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before :each do
    @user = FactoryBot.create(:user)
    test_sign_in(@user)
  end
  context 'GET#index' do
    it 'has show all users successfully' do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      get :index
      expect(assigns(:users)).to include user1
      expect(assigns(:users)).to include user2
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#show' do
    it 'has get user successfully' do
      get :show, params: { id: @user.id }
      expect(assigns(:user)).to eq(@user)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get invalid user' do
      get :show, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end
  context 'GET#new' do
    it 'has get new user successfully' do
      get :new
      expect(assigns(:user).id).to eq(nil)
      expect(assigns(:user).username).to eq(nil)
      expect(assigns(:user).email_id).to eq(nil)
      expect(assigns(:user).password).to eq(nil)
      expect(assigns(:user).level).to eq(nil)
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#edit' do
    it 'has get correct user successfully' do
      get :edit, params: { id: @user.id }
      expect(assigns(:user)).to eq(@user)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get user with invalid id' do
      get :edit, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'has create user successfully' do
      user = FactoryBot.build(:user)
      user_params = {
        user: {
          username: user.username,
          email_id: user.email_id,
          password: user.password,
          level: user.level,
          contact_no: user.contact_no
        }
      }
      post :create, params: user_params
      expect(assigns(:user).username).to eq user.username
      expect(assigns(:user).email_id).to eq user.email_id
      expect(assigns(:user).password).to eq user.password
      expect(assigns(:user).level).to eq user.level
      expect(assigns(:user).contact_no).to eq user.contact_no
      expect(response).to have_http_status(:created)
    end

    it 'has not create user with invalid inputs' do
      user_params = {
        user: {
          username: nil,
          email_id: nil,
          password: nil,
          level: nil,
          admin: nil,
          contact_no: nil
        }
      }
      post :create, params: user_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'has update user successfully' do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.build(:user)
      put :update,
          params: {
            id: user1.id,
            user: {
              username: user2.username,
              email_id: user2.email_id,
              password: user2.password,
              level: user2.level,
              admin: user2.admin,
              contact_no: user2.contact_no
            }
          }
      expect(assigns(:user).id).to eq user1.id
      expect(assigns(:user).username).to eq user2.username
      expect(assigns(:user).email_id).to eq user2.email_id
      expect(assigns(:user).password).to eq user2.password
      expect(assigns(:user).level).to eq user2.level
      expect(assigns(:user).contact_no).to eq user2.contact_no
      expect(response).to have_http_status(:ok)
    end

    it 'has not update user with invalid inputs' do
      user1 = FactoryBot.create(:user)
      put :update, params: {
        id: user1.id, user: {
          username: nil,
          email_id: nil,
          password: nil,
          level: nil
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'has not update user with invalid user' do
      put :update, params: { id: '123456', user: {
        username: @user.username,
        email_id: @user.email_id,
        password: @user.password,
        level: @user.level,
        admin: @user.admin
      } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'has destroy user successfully' do
      delete :destroy, params: { id: @user.id }
      expect(assigns(:user)).to eq @user
      expect(response).to have_http_status(:ok)
    end

    it 'has not destroy invalid user' do
      delete :destroy, params: { id: '12345' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
