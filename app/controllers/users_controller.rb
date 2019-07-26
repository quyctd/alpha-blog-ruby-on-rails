# frozen_string_literal: true

class UsersController < ApplicationController

  before_action :set_user, only: %i[edit update show]
  before_action :require_user, only: %i[edit update]
  before_action :require_same_user, only: %i[edit update]

  def index
    @users = User.paginate(page: params[:page], per_page: 1)
  end

  def new
    if logged_in? && !current_user.is_admin?
      redirect_to root_path
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Alpha blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 1)
  end

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
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = 'User and all articles created by user has been deleted'
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user && !current_user.is_admin?
      flash[:danger] = "You can edit when you are not #{@user.username}"
      redirect_to users_path
    end
  end

  def require_admin
    if logged_in? && !current_user.is_admin?
      flash[:danger] = 'Only admin can perform that action'
      redirect_to root_path
    end
  end

end