require 'test_helper'

class RequerimentsControllerTest < ActionController::TestCase
  setup do
    @requeriment = requeriments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requeriments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create requeriment" do
    assert_difference('Requeriment.count') do
      post :create, requeriment: { responsible_id: @requeriment.responsible_id }
    end

    assert_redirected_to requeriment_path(assigns(:requeriment))
  end

  test "should show requeriment" do
    get :show, id: @requeriment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @requeriment
    assert_response :success
  end

  test "should update requeriment" do
    put :update, id: @requeriment, requeriment: { responsible_id: @requeriment.responsible_id }
    assert_redirected_to requeriment_path(assigns(:requeriment))
  end

  test "should destroy requeriment" do
    assert_difference('Requeriment.count', -1) do
      delete :destroy, id: @requeriment
    end

    assert_redirected_to requeriments_path
  end
end
