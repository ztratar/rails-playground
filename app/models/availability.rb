class Availability
  include Mongoid::Document

  embedded_in :user

  validates_presence_of :day_of_week
  validates_uniqueness_of :day_of_week

  field :day_of_week, :type => String
  field :morning, :type => Boolean, :default => false
  field :afternoon, :type => Boolean, :default => false
  field :evening, :type => Boolean, :default => false
  field :night, :type => Boolean, :default => false
  field :late, :type => Boolean, :default => false

end