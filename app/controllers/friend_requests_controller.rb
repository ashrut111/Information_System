class FriendRequestsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @friend_requests = FriendRequest.joins(:user).where(receiver_id: current_user.id, accepted: nil)
  end

  def new
  end

  def create
    @friend_request = current_user.friend_requests.create(receiver_id: params[:user_id])
    if @friend_request.nil?
      flash[:alert] = "Unable to Send"
    else
      redirect_to users_path, notice: "Request Sent"
    end
  end
  
  def edit
  end

  def show
  end

  def update
    @friend_request = User.find(params[:id]).friend_requests.where(receiver_id: current_user.id)
    @friend_request.update(accepted: true)
    User.find(current_user.id).friend_requests.where(receiver_id: params[:id]).update(accepted: true)
    redirect_to user_friend_requests_path(current_user.id), notice: 'Request Accepted'
  end

  def destroy
    @friend_request = current_user.friend_requests.where(receiver_id: params[:id]).first
    if @friend_request.nil?
      @friend_request = User.find(params[:id]).friend_requests.where(receiver_id: current_user.id).first
    end
    @friend_request.destroy
    redirect_to request.referrer, notice: 'Request Rejected'
  end

end
