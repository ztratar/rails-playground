class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  embeds_many :availability
  embeds_many :work
  embeds_many :education
  embeds_many :chats_scheduled
  embeds_one :picture
  embeds_one :hometown
  embeds_one :location

  has_many :sent_requests, :dependent => :destroy, :foreign_key => "requester_id", :class_name => "Request"
  has_many :received_requests, :dependent => :destroy, :foreign_key => "host_id", :class_name => "Request"

  
  ## Database authenticatable
  field :fb_id, :type => Integer
  field :email,              :type => String, :null => false, :default => ""
  field :encrypted_password, :type => String, :null => false, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String
  field :chats_scheduled,    :type => Array
  field :chats_finished_count, :type => Integer, :default => 0

  ## Personal Info
  field :name, :type => String
  field :first_name, :type => String
  field :last_name, :type => String
  field :gender, :type => String
  field :help_bio, :type => String
  field :picture, :type => Hash

  ## Locations
  field :hometown, :type => Hash
  field :location, :type => Hash
  field :work, :type => Array
  field :education, :type => Array

  ## Hosting Info
  field :hosting, :type => Boolean
  field :timezone, :type => Integer
  field :availability, :type => Hash


  ## Encryptable
  # field :password_salt, :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
  data = access_token.extra.raw_info
  if user = User.where(:email => data.email).first
    user
  else # Create a user with a stub password. 
    User.create!(:email => data.email, :password => Devise.friendly_token[0,20]) 
  end
end

def self.new_with_session(params, session)
  super.tap do |user|
    if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
      user.email = data["email"]
    end
  end
end


end



class Work
  include Mongoid::Document
  field :fb_id, :type => Integer
  field :show_in_card, :type => Boolean, :default => true
  field :name, :type => String
  field :description, :type => String
  field :start_date, :type => DateTime
  field :location_name, :type => String
  field :location_lat, :type => Integer
  field :location_long, :type => Integer
  embedded_in :user
end