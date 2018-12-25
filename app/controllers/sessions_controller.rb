# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :logged_in, only: [:destroy]

  def new
  end
    
  def create
    user = User.authenticate(params[:email_id],
                             params[:password])
    if user
      log_in user
      redirect_to(subjects_path)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      redirect_to(login_path)
      render json: { errors: @subject.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to(login_path)
  end
end
