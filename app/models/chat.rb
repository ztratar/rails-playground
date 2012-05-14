class Chat
  include Mongoid::Document
  belongs_to :request

  embeds_many :messages

  field :host_id, :type => Integer
  field :requestee_id, :type => Integer
  field :session_id, :type => Integer

  field :start_time, :type => Time
  field :end_time, :type => Time
  field :host_in_chat, :type => Boolean
  field :requestee_in_chat, :type => Boolean

  class << self

	  def init_opentok
	  	@opentok = OpenTok::OpenTokSDK.new 14712672, "3da704cbbda26bb38e50d430d0fecfd7ffc0269f"
      @opentok.api_url = 'https://staging.tokbox.com/hl'
      return @opentok
	  end


	  def init_session(chat)
      @opentok = init_opentok
      if chat.session_id.nil?
	      id = @opentok.create_session '127.0.0.1'
	      tok_session = id.to_s
	      chat.session_id = tok_session
	      chat.save
		  end
		  return chat
	  end

	  def gen_token(chat)
	  	@opentok = init_opentok
	  	@tok_token = @opentok.generate_token :session_id => chat.session_id
  		return @tok_token
	  end

  end

end


class Message
  include Mongoid::Document
  embedded_in :chat

  field :user_id, type: Integer
  field :username, type: String
  field :content, type: String
  field :time_created, type: Time
end
