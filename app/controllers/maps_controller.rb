class MapsController < ApplicationController
  def index
    @meetups_near_me = Array.new
    @courses = Array.new

    @venues_near_me = Venue.near([current_user.latitude, current_user.longitude], current_user.max_distance)

    @venues_near_me.each do |venue|
      @meetups_near_me << venue.meetups if venue.meetups.length > 0
    end

    @meetups_near_me.flatten!

    @meetups_near_me.each do |meetup|
      @courses << meetup.course.title
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
            city: venue.city,
            state: venue.state,
            zip: venue.zip,
            meetups: venue.courses,
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
end
