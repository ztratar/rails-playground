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