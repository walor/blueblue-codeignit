require 'test_helper'

class WareHousesControllerTest < ActionController::TestCase
  setup do
    @ware_house = ware_houses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ware_houses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ware_house" do
    assert_difference('WareHouse.count') do
      post :create, ware_house: { name: @ware_house.name, responsible_id: @ware_house.responsible_id }
    end

    assert_redirected_to ware_house_path(assigns(:ware_house))
  end

  test "should show ware_house" do
    get :show, id: @ware_house
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ware_house
    assert_response :success
  end

  test "should update ware_house" do
    put :update, id: @ware_house, ware_house: { name: @ware_house.name, responsible_id: @ware_house.responsible_id }
    assert_redirected_to ware_house_path(assigns(:ware_house))
  end

  test "should destroy ware_house" do
    assert_difference('WareHouse.count', -1) do
      delete :destroy, id: @ware_house
    end

    assert_redirected_to ware_houses_path
  end
end
