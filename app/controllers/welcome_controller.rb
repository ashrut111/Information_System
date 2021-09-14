class WelcomeController < ApplicationController
  def index
    if current_user.nil?
    else
      @welcome = current_user.id
    end
  end
end