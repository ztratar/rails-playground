class Profile < ActiveRecord::Base
  attr_accessible :about, :city, :country, :created_at, :first_name, :last_name, :state, :updated_at, :zipcode
end
