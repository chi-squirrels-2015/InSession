class UsersController < ApplicationController
  respond_to :html, :json, :js
  def index
    @meetups_near_me = Array.new
    @courses = Array.new

    @venues_near_me = Venue.near([current_user.latitude,current_user.longitude], current_user.max_distance)

    @venues_near_me.each do |venue|
      @meetups_near_me << venue.meetups if venue.meetups.length > 0
    end

    @meetups_near_me.flatten!

    @meetups_near_me.each do |meetup|
      @courses << meetup.course
    end

    @geojson = Array.new

    @venues_near_me.each do |venue|
      @geojson << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [venue.longitude, venue.latitude]
        },
        properties: {
          name: venue.name,
          address: venue.address,
          :'marker-color' => '#79BD9A',
          :'marker-symbol' => 'circle',
          :'marker-size' => 'medium'
        }
      }
    end

    respond_to do |format|
      format.html
      format.json { render json: @geojson }  # respond with the created JSON object
    end

  end

  def show
    @user = current_user.id
  end
end
