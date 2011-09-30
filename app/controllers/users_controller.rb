class UsersController < ApplicationController

  def new
    @user = User.new()
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default home_index_url
    else
      render :action => :new
    end
  end
end
