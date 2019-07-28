class CategoriesController < ApplicationController

  before_action :require_admin, except: %i[index show serve]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Category was created successfully'
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = 'Category name was updated successfully'
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def serve
    @category = Category.find(params[:id])
    send_data(@category.image_data, type: @category.mime_type, filename: "#{@category.image_name}.jpg", disposition: "inline")
  end

  private

  def category_params
    ret = {}
    ret[:name] = params[:category][:name]
    if params[:category][:image_data]
      ret[:image_data]  = params[:category][:image_data].read
      ret[:image_name]  = params[:category][:image_data].original_filename
      ret[:mime_type]   = params[:category][:image_data].content_type
    end
    puts ret
    ret
  end

  def require_admin
    if !logged_in? || (logged_in? && !current_user.is_admin?)
      flash[:danger] = 'Only admin can perform that action'
      redirect_to categories_path
    end
  end

end