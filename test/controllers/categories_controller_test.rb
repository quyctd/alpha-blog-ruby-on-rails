require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: 'sports')
  end

  # test 'should get categories index' do
  #   get :index
  #   assert_response :success
  # end
  #
  # test 'should get new' do
  #   get :new
  #   assert_response :success
  # end
  #
  # test 'should get show' do
  #   get categories_path(@category)
  #   assert_response :success
  # end
end