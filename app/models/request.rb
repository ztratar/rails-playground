class Request
  include Mongoid::Document
  belongs_to :user
  has_one :chat, :dependent => :destroy, :foreign_key => "request_id", :class_name => "Chat"

  embeds_many :reqtime
  
  field :host_id, :type => Integer
  field :requestee_id, :type => Integer
  field :requester_confirmation, :type => Boolean
  field :host_confirmation, :type => Boolean
  field :why, :type => String
  field :ping_pong, :type => Integer

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

  def requests(host_id)
    Request.where(:host_id => host_id)
  end

  def requested(requestee_id)
    Request.where(:requestee_id => requestee_id)
  end
  
end

# Embed

class Reqtime
  include Mongoid::Document
  embedded_in :request

  field :start_time, :type => Time
  field :end_time, :type => Time
end