# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit update show destroy]
  before_action :require_user, except: %i[index show serve]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    @articles = Article.all.order("created_at DESC")
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = 'Article was successfully created'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @article.update(article_params)
      flash[:success] = 'Article was updated'
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:danger] = 'Article was success deleted'
    redirect_to articles_path
  end

  def serve
    @article = Article.find(params[:id])
    send_data(@article.image_data, type: @article.mime_type, filename: "#{@article.image_name}.jpg", disposition: "inline")
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    ret = {}
    ret[:title] = params[:article][:title]
    ret[:description] = params[:article][:description]
    ret[:category_ids] = params[:article][:category_ids]
    if params[:article][:image_data]
      ret[:image_data]  = params[:article][:image_data].read
      ret[:image_name]  = params[:article][:image_data].original_filename
      ret[:mime_type]   = params[:article][:image_data].content_type
    end
    ret
  end

  def require_same_user
    if current_user != @article.user && !current_user.is_admin?
      flash[:danger] = 'Your can only edit or delete your article'
      redirect_to root_path
    end
  end
end
