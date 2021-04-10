require 'test_helper'

class OwnerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @owner = Owner.new(name: "Example Owner", email: "owner@example.com", password: "123456", password_confirmation: "123456")
  end

  test "owner_name should not be too long" do
    @owner.name = "a" * 51
    assert_not @owner.valid?
  end

  test "owner_email should not be too long" do
    @owner.email = "a" * 244 + "@example.com"
    assert_not @owner.valid?
  end

   test "owner_email validation should reject invalid addresses" do
    invalid_addresses = %w[owner@example,com owner_at_foo.org owner.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @owner.email = invalid_address
      assert_not @owner.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "owner_email addresses should be unique" do
    duplicate_owner = @owner.dup
    duplicate_owner.email = @owner.email.upcase
    @owner.save
    assert_not duplicate_owner.valid?
  end

  test "owner_email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @owner.email = mixed_case_email
    @owner.save
    assert_equal mixed_case_email.downcase, @owner.reload.email
  end

  test "owner_password should be present (nonblank)" do
    @owner.password = @owner.password_confirmation = " " * 6
    assert_not @owner.valid?
  end

  test "owner_password should have a minimum length" do
    @owner.password = @owner.password_confirmation = "a" * 5
    assert_not @owner.valid?
  end
end
