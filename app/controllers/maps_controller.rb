class MapsController < ApplicationController
  def index
    @meetups_near_me = Array.new
    @courses = Array.new

    @venues_near_me = Venue.near([current_user.latitude, current_user.longitude], current_user.max_distance)

    @venues_near_me.to_a.reject!{|v| v.meetups.length == 0}

    # @venues_near_me.each do |venue|
    #   @meetups_near_me << venue.meetups if venue.meetups.length > 0
    # end
    # @meetups_near_me.flatten!

    # @meetups_near_me.each do |meetup|
    #   @courses << [meetup.course.title, meetup.id]
    # end

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
            meetup_urls: venue.meetups.map{|m| view_context.link_to(m.course.title, meetup_path(m)) },
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
