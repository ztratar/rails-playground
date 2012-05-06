class Chat < ActiveRecord::Base
  attr_accessible :event, :session_id

  belongs_to :request
end
