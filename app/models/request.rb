class Request
  include Mongoid::Document
  field :requester_id, :type => Integer
  field :host_id, :type => Integer
  field :requester_confirmation, :type => Boolean
  field :host_confirmation, :type => Boolean
  field :latest_message, :type => String
  field :ping_pong, :type => Integer
  embeds_one  :reqtimes
  validates_associated :reqtimes
  accepts_nested_attributes_for :reqtimes

  has_one :chat
end