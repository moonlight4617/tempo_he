require 'test_helper'

class OwnersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @owner = Owner.new(name: "Example Owner", email: "owner@example.com", password: "123456", password_confirmation: "123456")
  end

  test "owner_should be valid" do
    assert @owner.valid?
  end

  test "owner_name should be present" do
    @owner.name = ""
    assert_not @owner.valid?
  end

  test "owner_email should be present" do
    @owner.email = " "
    assert_not @owner.valid?
  end

end
