# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :logged_in, only: %i[index show]
  before_action :admin_user, only: %i[edit update new destroy]

  def new
    @question = Question.new
    respond_to do |format|
      format.html {}
      format.json { render json: { question: @question }, status: :ok }
    end
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      render json: { question: @question }, status: :created
    else
      render json: { errors: @question.errors }, status: :unprocessable_entity
    end
  end

  def show
    @question = Question.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { question: @question }, status: :ok }
      format.json { render json: { question: @question }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    render json: {}, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def index
    @questions = Question.all
    render json: { questions: @questions }, status: :ok
  end

  def edit
    @question = Question.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { question: @question }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)

      render json: { question: @question }, status: :ok

    else
      render json: @question.errors, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def question_params
    params.require(:question).permit(:name, :option_a, :option_b, :option_c, :option_d, :ans,
                                     :ques_type, :is_active, :questionset_id)
  end
end
