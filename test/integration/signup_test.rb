require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest

  test "invalid signup_for_user information" do
    get u_new_path
    assert_no_difference 'User.count' do
      post u_create_path, params: { user: { name:  "", email: "user@invalid", password: "foo", password_confirmation: "bar" } }
    end
  end

  test "valid signup_for_user information" do
    get u_new_path
    assert_difference 'User.count', 1 do
      post u_create_path, params: { user: { name:  "Example User", email: "user@example.com", password: "password", password_confirmation: "password" } }
    end
    follow_redirect!
    assert_not flash.empty?
    assert_not session[:user_id].nil?
  end
  
  test "invalid signup_for_owner information" do
    get o_new_path
    assert_no_difference 'Owner.count' do
      post o_create_path, params: { owner: { name:  "", email: "owner@invalid", password: "foo", password_confirmation: "bar" } }
    end
  end

  test "valid signup_for_owner information" do
    get o_new_path
    assert_difference 'Owner.count', 1 do
      post o_create_path, params: { owner: { name:  "Example Owner", email: "owner@example.com", password: "password", password_confirmation: "password" } }
    end
    follow_redirect!
    assert_not flash.empty?
    assert_not session[:owner_id].nil?
  end

  test "valid signup_for_shop" do
    name = "Example Shop"
    prefecture = "sample"
    city = "sample"
    tel = "123456789"
    station = "sample"
    zip_code = "1234567"

    @owner = owners(:owner_ryoji)
    assert_difference 'Shop.count', 1 do
      @owner.shops.create(name: name, prefecture: prefecture, city: city, tel: tel, station: station, zip_code: zip_code)
    end
  end
end