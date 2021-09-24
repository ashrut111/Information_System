class UsersController < ApplicationController
  before_action :show_users, only: :index
  
  def index    
    if @users.blank?
      flash.now[:alert] = "No users found"
    else
      flash.now[:notice] = "#{@users.ids.count} User(s) found"
    end
  end

  def update
    current_user.image.attach(params[:image])
    redirect_to root_path, notice: "Profile Picture Updated"
  end

  private
   
  def show_users
    unless params[:search].blank?
      @users = User.where("name LIKE ?", "%#{params[:search]}%").where.not(id: current_user.id)
    end
  end

end
