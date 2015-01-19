class IdeasController < ApplicationController

  before_filter :authorize, only: [:show]
  def show
    if current_user.ideas.all.count == 1
      @ideas = Array.new(1,current_user.ideas.all)
    else
      @ideas = current_user.ideas.all
    end
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def update
    puts "Idea Id: #{params[:id]}"
    puts "updated title: #{params[:idea][:title]}"
    puts "updated text: #{params[:idea][:text]}"
    Idea.find(params[:id])
        .update_attributes( title: params[:idea][:title],
                            text: params[:idea][:text],
                            category_id: params[:idea][:category_id])
    redirect_to idea_path(current_user)
  end

  def new
    @idea = Idea.new(title: params[:title], text: params[:text], user_id: current_user.id)
  end

  def create
    puts "outputting params"
    puts params.inspect
    puts "new title"
    puts params[:idea][:title]
    puts "new text"
    puts params[:idea][:text]
    puts "user_id"
    puts params[:idea][:user_id]
    Idea.create(title: params[:idea][:title],
                text: params[:idea][:text],
                user_id: params[:idea][:user_id],
                category_id: params[:idea][:category_id])

    redirect_to idea_path(current_user)
  end

  def destroy
    puts "Id of post to be destroyed #{params[:id]}"
    Idea.find(params[:id]).destroy
    redirect_to idea_path(current_user)
  end


end
