class Chat
  include Mongoid::Document

  field :request_id, :type => Integer
  field :session_id, :type => String
  field :messages, :type => Array

  belongs_to :request
end
