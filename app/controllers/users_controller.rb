class UsersController < ApplicationController
before_filter :require_user, :except => [:new,:create]
  def new
    @user = User.new()
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Registration successful!"
      redirect_back_or_default home_index_url
    else
      render :action => :new
    end
  end
  
  def edit
      @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
    #raise params[:user].inspect
    if @user.update_attributes(params[:user])
      flash[:notice] = "User information updated successfully"
      redirect_back_or_default profile_user_path
    else
      render :action => :edit
      
    end
    
  end
  
  
  def profile
    @user = current_user
      
  end
  
  def changepassword
       @user = current_user
     # 
       if request.post?
          if params[:user][:password].blank?
              @user.errors[:base] << "New Password is blank."
          render :action => :changepassword
          
          else
        
        if @user.update_attributes(params[:user])
            flash[:notice] = "Password changed succesfully."
            redirect_back_or_default profile_user_path(current_user)
          else
            render :action => :changepassword
            
          end
        
        end 
       end
  end
  
  def accountdeactivate
         @user = current_user
         
         if @user.update_attribute(:is_active, false)
         flash[:notice] = "Your account have been deactivated. In future if you need this account, please contact us."         
         redirect_back_or_default profile_user_path(current_user)
         else
          flash[:notice] = "Operation couldnot not be completed. Please try again "         
         redirect_back_or_default profile_user_path(current_user)
        
         end
         
         # current_user_session.destroy
         # flash[:notice] = "Your account have been deactivated. In future if you need this account, please contact us."
          #redirect_back_or_default home_index_url
  end
  
end
