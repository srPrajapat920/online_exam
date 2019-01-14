# frozen_string_literal: true

class ExamsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :logged_in, only: [:new]
  before_action :admin_user, only: [:index, :show, :edit, :update, :destroy]
  def new
    @exam = Exam.new
    respond_to do |format|
      format.html {}
      format.json { render json: { exam: @exam }, status: :ok }
    end
  end

  def create
    @exam = Exam.new(exam_params)
    if @exam.save
      render json: { exam: @exam }, status: :created
    else
      render json: { errors: @exam.errors }, status: :unprocessable_entity
    end
  end

  def show
    @exam = Exam.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { exam: @exam }, status: :ok }
      format.json { render json: { exam: @exam }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def destroy
    @exam = Exam.find(params[:id])
    @exam.destroy
    render json: {}, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def index
    @exams = Exam.all
    respond_to do |format|
      format.html {}
      format.json { render json: { exams: @exams }, status: :ok }
    end
  end

  def edit
    @exam = Exam.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { exam: @exam }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def update
    @exam = Exam.find(params[:id])
    if @exam.update(exam_params)
      render json: { exam: @exam }, status: :ok
    else
      render json: @exam.errors, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def exam_params
    params.permit(:total_marks, :attended_ques, :user_id, :questionset_id)
  end
end
