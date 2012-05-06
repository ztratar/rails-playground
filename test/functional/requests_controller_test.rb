require 'test_helper'

class RequestsControllerTest < ActionController::TestCase
  setup do
    @request = requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create request" do
    assert_difference('Request.count') do
      post :create, request: { host_confirmation: @request.host_confirmation, host_id: @request.host_id, latest_message: @request.latest_message, ping_pong: @request.ping_pong, requester_confirmation: @request.requester_confirmation, requester_id: @request.requester_id }
    end

    assert_redirected_to request_path(assigns(:request))
  end

  test "should show request" do
    get :show, id: @request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @request
    assert_response :success
  end

  test "should update request" do
    put :update, id: @request, request: { host_confirmation: @request.host_confirmation, host_id: @request.host_id, latest_message: @request.latest_message, ping_pong: @request.ping_pong, requester_confirmation: @request.requester_confirmation, requester_id: @request.requester_id }
    assert_redirected_to request_path(assigns(:request))
  end

  test "should destroy request" do
    assert_difference('Request.count', -1) do
      delete :destroy, id: @request
    end

    assert_redirected_to requests_path
  end
end
