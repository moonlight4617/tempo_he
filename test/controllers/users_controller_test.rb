require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "123456", password_confirmation: "123456")
  end

  test "user_should be valid" do
    assert @user.valid?
  end

  test "user_name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "user_email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end
end
