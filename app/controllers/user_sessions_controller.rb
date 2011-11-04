class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    

    if @user_session.save
        @current_user_session = UserSession.find
        if @current_user_session 
          current_user = @current_user_session.user
          if  current_user && !current_user.is_active?
              current_user_session.destroy
              flash[:notice] = "Your account has been Deactivated!"
              redirect_back_or_default home_index_url
           else
          flash[:notice] = "Login successful!"
          redirect_back_or_default home_index_url 
           end    
        else
          flash[:notice] = "Login successful!"
          redirect_back_or_default home_index_url
      end
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default home_index_url
  end

end
