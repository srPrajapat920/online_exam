# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :logged_in, only: [:destroy]

  def new
   @user=User.new
  end

  def create
    user = User.authenticate(params[:session][:email_id],
                             params[:session][:password])
    if user
      log_in user
      redirect_to(subjects_path)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      redirect_to(login_path)
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to(login_path)
  end
end
