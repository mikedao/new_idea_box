require 'test_helper'

class UserIdeasTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  attr_reader :user, :idea

  def setup
    @user = User.create(name: "example", password: "password", role: 0)
    @idea = Idea.create(title: "idea title",
                        text: "idea text",
                        user_id: @user.id,
                        category_id: 1)
  end

  test "a user can view their ideas page" do
    ApplicationController.any_instance.stubs(:current_user)
                        .returns(user)
    puts user.id
    puts user.ideas.first.user_id
    puts idea.pretty_print_inspect
    visit idea_path(user)
    assert page.has_content?("idea title")
  end

end

