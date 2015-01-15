class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in."
      redirect_to user_path(user)
    else
      flash[:errors] = "Invalid login"
      render :new
    end

  end


end
