require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get user_index" do
    get admin_user_index_url
    assert_response :success
  end

  test "should get owner_index" do
    get admin_owner_index_url
    assert_response :success
  end

end
