# frozen_string_literal: true

class SubjectsController < ApplicationController
  before_action :admin_user, only: [:index, :edit, :new, :show, :destroy]
  def new
    @subject = Subject.new
    respond_to do |format|
      format.html {}
      format.json { render json: { subject: @subject }, status: :ok }
    end
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      render json: { subject: @subject }, status: :created
    else
      render json: { errors: @subject.errors }, status: :unprocessable_entity
    end
  end

  def show
    @subject = Subject.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { subject: @subject }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    render json: {}, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def index
    @subjects = Subject.all
    respond_to do |format|
      format.html {}
      format.json { render json: { subjects: @subjects }, status: :ok }
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { subject: @subject }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update(subject_params)
      render json: { subject: @subject }, status: :ok
    else
      render json: @subject.errors, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def subject_params
    params.require(:subject).permit(:name)
  end
end
