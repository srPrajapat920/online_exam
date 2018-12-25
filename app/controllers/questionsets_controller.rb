# frozen_string_literal: true

class QuestionsetsController < ApplicationController
  before_action :logged_in, only: [:index, :show]
  before_action :admin_user, only: [:edit, :new, :destroy]

  def new
    @questionset = Questionset.new
    respond_to do |format|
      format.html {}
      format.json { render json: { questionset: @questionset }, status: :ok }
    end
  end

  def create
    @questionset = Questionset.new(questionset_params)
    if @questionset.save
      render json: { questionset: @questionset }, status: :created
    else
      render json: { errors: @questionset.errors }, status: :unprocessable_entity
    end
  end

  def show
    @questionset = Questionset.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { questionset: @questionset }, status: :ok }
      format.json { render json: { questionset: @questionset }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def destroy
    @questionset = Questionset.find(params[:id])
    @questionset.destroy
    render json: {}, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def index
    @questionsets = Questionset.all
    render json: { questionsets: @questionsets }, status: :ok
  end

  def edit
    @questionset = Questionset.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { questionset: @questionset }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def update
    @questionset = Questionset.find(params[:id])
    if @questionset.update(questionset_params)
      render json: { questionset: @questionset }, status: :ok
    else
      render json: @questionset.errors, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def questionset_params
    params.require(:questionset).permit(:name, :no_ques, :time, :level, :marks_per_ques,
                                        :is_active, :subject_id)
  end
end
