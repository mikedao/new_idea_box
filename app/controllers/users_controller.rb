class UsersController < ApplicationController
  before_filter :authorize, only: [:show]
  def show
    @user = User.find(params[:id])
    flash[:alert] = "Hello Admin" if current_user.admin?
    authorize! :read, @user
  end

  def new
    @user = User.new(name: params[:name],
                     password: params[:password],
                     password_confirmation: params[:password_confirmation],
                     role: params[:role])
  end

  def create
    puts "outputting params"
    puts params.inspect
    puts "user name"
    puts params[:user][:name]
    puts "password"
    puts params[:user][:password]
    puts "password confirmation"
    puts params[:user][:password_confirmation]

    User.create(name: params[:user][:name],
                password: params[:user][:password],
                password_confirmation: params[:user][:password_confirmation],
                role: 0)
    redirect_to login_path
  end


end
