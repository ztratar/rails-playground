class Request
  include Mongoid::Document

  field :requester_id, :type => String
  field :host_id, :type => String
  field :requester_confirmation, :type => Boolean
  field :host_confirmation, :type => Boolean
  field :latest_message, :type => String
  field :ping_pong, :type => Integer
  field :reqtimes, :type => Array

  belongs_to :user
  has_one :chat
end