class UsersController < ApplicationController
  before_action :show_users, only: :index

  def index
    if @users.blank?
      flash.now[:alert] = "No users found"
    else
      flash.now[:notice] = "#{@users.ids.count} user(s) found"
    end
  end

  def edit
    
  end
  
  def update
    debugger
    current_user.image.attach(params[:image])
    current_user.update(user_params)
    debugger
    redirect_to root_path
  end

  def friend_requests
    @users = User.all
  end

  def accept_request
  end

  def reject_request
  end

  private
   
  def show_users
    unless params[:search].blank?
      @users = User.where("name LIKE ?", "%#{params[:search]}%")
    end
  end

  def user_params
    params.require(:user).permit(:image)
  end
end
