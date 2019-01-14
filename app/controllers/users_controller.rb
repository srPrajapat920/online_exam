# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in, only: [:show, :edit]
  before_action :admin_user, only: [:index, :destroy]
  def new
    @user = User.new
    respond_to do |format|
      format.html {}
      format.json { render json: { user: @user }, status: :ok }
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      respond_to do |format|
        format.json { render json: { user: @user }, status: :created }
      end
    else
      respond_to do |format|
        format.json {render json: { errors: @user.errors }, status: :unprocessable_entity}
      end
    end  
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { user: @user }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: {}, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def index
    @users = User.all
    respond_to do |format|
      format.html {}
      format.json { render json: { users: @users }, status: :ok }
    end
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { user: @user }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: { user: @user }, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def user_params
    params.permit(:username, :email_id, :password, :contact_no, :level, :admin, :id)
  end
end
