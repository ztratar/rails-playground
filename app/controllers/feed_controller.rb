class FeedController < ApplicationController
  def index
    @users = User.all_hosts.entries
    render :rabl => @users
  end
end