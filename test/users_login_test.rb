
require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  attr_reader :user


  def setup
    @user = User.create(username: "example", password: "password")
    visit login_path
  end


  test "a registered user can view their profile" do
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit user_path(user)
    within("#banner") do
      assert page.has_content?("Welcome, example")
    end
  end
end

