require 'test_helper'

class RequerimentItemsControllerTest < ActionController::TestCase
  setup do
    @requeriment_item = requeriment_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requeriment_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create requeriment_item" do
    assert_difference('RequerimentItem.count') do
      post :create, requeriment_item: { quantity: @requeriment_item.quantity }
    end

    assert_redirected_to requeriment_item_path(assigns(:requeriment_item))
  end

  test "should show requeriment_item" do
    get :show, id: @requeriment_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @requeriment_item
    assert_response :success
  end

  test "should update requeriment_item" do
    put :update, id: @requeriment_item, requeriment_item: { quantity: @requeriment_item.quantity }
    assert_redirected_to requeriment_item_path(assigns(:requeriment_item))
  end

  test "should destroy requeriment_item" do
    assert_difference('RequerimentItem.count', -1) do
      delete :destroy, id: @requeriment_item
    end

    assert_redirected_to requeriment_items_path
  end
end
