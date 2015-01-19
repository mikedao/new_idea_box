
require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  attr_reader :user


  def setup
    @user = User.create(name: "example", password: "password")
    visit login_path
  end


  test "a registered user can view their profile" do
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit user_path(user)
    within("#banner") do
      assert page.has_content?("Welcome, example")
    end
  end

  test "registered user can log in" do
    fill_in "session[name]", with: "example"
    fill_in "session[password]", with: "password"
    click_link_or_button "Login"
    assert page.has_content?("You have successfully logged in.")
  end


  test "an unregistered user cannot view a profile" do
    ApplicationController.any_instance.stubs(:current_user).returns(nil)
    visit user_path(user)
    within("#flash_alert") do
      assert page.has_content?("Not authorized")
    end
  end


  test "registered user cannot view other users' profile" do
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    protected_user = User.create(name: "protected",  password: "password", password_confirmation: "password")
    visit user_path(protected_user)
    within("#flash_alert") do
      assert page.has_content?("You are not authorized to access this page")
    end
  end

  test 'admin user can view any users\'s profile' do
    admin_user = User.create(name: "protected", password:"foobar", password_confirmation: "foobar", role: 1)
    ApplicationController.any_instance.stubs(:current_user).returns(admin_user)
    visit user_path(user)
    within("#flash_alert") do
      assert page.has_content?("Hello Admin")
    end
  end
end
