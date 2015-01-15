
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
    within("#banner") do
      assert page.has_content?("Welcome, example")
    end
  end


end
