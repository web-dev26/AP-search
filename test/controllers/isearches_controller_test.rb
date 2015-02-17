require 'test_helper'

class IsearchesControllerTest < ActionController::TestCase
  setup do
    @isearch = isearches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:isearches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create isearch" do
    assert_difference('Isearch.count') do
      post :create, isearch: {  }
    end

    assert_redirected_to isearch_path(assigns(:isearch))
  end

  test "should show isearch" do
    get :show, id: @isearch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @isearch
    assert_response :success
  end

  test "should update isearch" do
    patch :update, id: @isearch, isearch: {  }
    assert_redirected_to isearch_path(assigns(:isearch))
  end

  test "should destroy isearch" do
    assert_difference('Isearch.count', -1) do
      delete :destroy, id: @isearch
    end

    assert_redirected_to isearches_path
  end
end
