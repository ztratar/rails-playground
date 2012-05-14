class FeedController < ApplicationController
  def index
    users = User.hosting?.entries

    render :json => users
  end