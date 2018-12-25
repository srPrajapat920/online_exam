# frozen_string_literal: true

class TestsController < ApplicationController
  before_action :logged_in, only:[:index,:show,:exm]	
  def index
    @current_user = current_user.username
  end

  def show
  	@current_user = current_user.username
  end

  def exm
  end	
end