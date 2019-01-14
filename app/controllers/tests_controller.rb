# frozen_string_literal: true

class TestsController < ApplicationController
  before_action :logged_in, only:[:index,:show,:exm]	
  def index
  	@tests = Subject.all
    respond_to do |format|
      format.html {}
      format.json { render json: { subjects: @tests }, status: :ok }
    end
    
  end

  def show
  	@test = Subject.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { subject: @test }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def questionset
    @questionsets = Questionset.all
    render json: { questionsets: @questionsets }, status: :ok
  end

  def qsetshow
    @questionset = Questionset.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { questionset: @questionset }, status: :ok }
      format.json { render json: { questionset: @questionset }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def ques
    @questions = Question.all
    render json: { questions: @questions }, status: :ok
  end


  def exm
  	@test = Questionset.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { questionset: @test }, status: :ok }
      format.json { render json: { questionset: @test }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end	
end