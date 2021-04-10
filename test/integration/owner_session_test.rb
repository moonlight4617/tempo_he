require 'test_helper'

class OwnersSessionTest < ActionDispatch::IntegrationTest

  def setup
    @owner = owners(:owner_ryoji)
  end

  test "owner_login with invalid information" do
    get owner_login_path
    post owner_logged_in_path, params: { owner_session: { email: "", password: "" } }
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "owner_login with valid information followed by logout" do
    get owner_login_path
    post owner_logged_in_path, params: { owner_session: { email: @owner.email, password: 'password' } }
    assert_not session[:owner_id].nil?
    follow_redirect!
    delete owner_logout_path
    assert session[:owner_id].nil?
  end
  
  test "login_owner with remembering and without remembering" do
    # クッキーを保存してログイン
    log_in_as_owner(@owner, remember_owner: '1')
    assert_not_empty cookies['remember_owner_token']
    delete owner_logout_path
    # クッキーを削除してログイン
    log_in_as_owner(@owner, remember_owner: '0')
    assert_empty cookies['remember_owner_token']
  end

end