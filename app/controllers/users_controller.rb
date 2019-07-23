# frozen_string_literal: true

class UsersController < ApplicationController

  before_action :set_user, only: %i[edit update show]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Alpha blog #{@user.username}"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your account was update successful'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end