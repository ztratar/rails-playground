class Request
  include Mongoid::Document

  field :host_id, :type => Integer
  field :requestee_id, :type => Integer
  field :requester_confirmation, :type => Boolean
  field :host_confirmation, :type => Boolean
  field :times, :type => Array
  field :why, :type => String
  field :ping_pong, :type => Integer

  belongs_to :user
  has_one :chat, :dependent => :destroy, :foreign_key => "request_id", :class_name => "Chat"

  def set_chat
    if self.host_confirmation && self.requester_confirmation && chat.nil?
      spawn = Chat.create(:request_id => self.id)
      spawn.save
    end
  end

  def has_chat?
    if !chat.nil?
      return true
    else
      return false
    end
  end

end