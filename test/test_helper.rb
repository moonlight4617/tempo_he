ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(user)
    session[:user_id] = user.id
  end
end

class ActionDispatch::IntegrationTest
  # テストユーザーとしてログインする
  def log_in_as(user, password: 'password', remember_me: '1')
    post user_logged_in_path, params: { user_session: { email: user.email, password: password, remember_me: remember_me } }
  end

  def log_in_as_owner(owner, password: 'password', remember_owner: '1')
    post owner_logged_in_path, params: { owner_session: { email: owner.email, password: password, remember_owner: remember_owner } }
  end
end
