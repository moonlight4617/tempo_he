require 'test_helper'

class TagToShopsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get tag_to_shops_new_url
    assert_response :success
  end

  test "should get create" do
    get tag_to_shops_create_url
    assert_response :success
  end

  test "should get delete" do
    get tag_to_shops_delete_url
    assert_response :success
  end

end
