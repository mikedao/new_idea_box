class UsersController < ApplicationController
  before_filter :authorize, only: [:show]
  def show
    @user = User.find(params[:id])
    flash[:alert] = "Hello Admin" if current_user.admin?
    authorize! :read, @user
  end

end
