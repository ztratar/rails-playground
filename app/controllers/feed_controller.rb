class FeedController < ApplicationController
  def index
    users = User.all_hosts.entries

    render :json => users
  end
end