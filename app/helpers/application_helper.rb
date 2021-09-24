module ApplicationHelper
  def check_friendship(user_id)
    if current_user.unaccepted_request(user_id) == false
      return "Request yet to be accpeted..."
    else
      if current_user.not_a_friend(user_id)
        return button_to "Send Friend-Request", user_friend_requests_path(user_id), method: :post
      else
        return button_to "Unfriend", user_friend_request_path(current_user.id, user_id), method: :delete
      end
    end
  end
end
