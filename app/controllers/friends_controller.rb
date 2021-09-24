class FriendsController < ApplicationController
  def index
    @friends = (User.joins(:friend_requests).where(friend_requests: {sender_id: current_user.id, accepted: true}) and User.joins(:friend_requests).where(friend_requests: {receiver_id: current_user.id, accepted: true}))
    if @friends.blank?
      render "no_friends"
    end
  end
end
