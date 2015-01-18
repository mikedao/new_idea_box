class IdeasController < ApplicationController
  def show
    @ideas = current_user.ideas.all
  end

end
