# frozen_string_literal: true

# Session controller
class SessionsController < ApplicationController

  def new
    if logged_in?
      flash[:danger] = "You already logged in!"
      redirect_to root_path
    end
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = 'You have successfully logged in'
      redirect_to user_path(@user)
    else
      flash.now[:danger] = 'Username or password not correct'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'You have logged out'
    redirect_to root_path
  end

end
