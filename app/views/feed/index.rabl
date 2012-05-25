collection @users
  attributes :id, :fb_id, :name, :first_name, :last_name, :hosting, :timezone, :chats_finished_count, :help_bio

  child :picture do
    attributes :src, :width, :height
  end

  child :availability do
    attributes :day_of_week, :morning, :afternoon, :evening, :night, :late
  end

  child :scheduled_chat do
    attributes :start_time, :end_time
  end

  child :work do
    attributes :fb_id, :show_in_card, :name, :description, :start_date, :location_name, :location_lat, :location_long
  end

  child :education do
    attributes :type, :fb_id, :show_in_card, :name, :concentration, :picture_src
  end

  child :location do
    attributes :fb_id ,:show_in_card, :name, :location_lat, :location_long
  end

  child :hometown do
    attributes :fb_id, :name, :show_in_card, :location_lat, :location_long
  end