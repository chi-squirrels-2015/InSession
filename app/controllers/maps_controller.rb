class MapsController < ApplicationController
  def index


    respond_to do |format|
      format.html
      format.json do
        if params[:meetup_id]
          @meetup = Meetup.find(params[:meetup_id])
          @venues_near_me = [@meetup.venue]
        else
          @meetups_near_me = Array.new
          @courses = Array.new

          @venues_near_me = Venue.near([current_user.latitude, current_user.longitude], current_user.max_distance)

          @venues_near_me.to_a.reject!{|v| v.meetups.length == 0}
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
                meetup_urls: venue.meetups.map{|m| view_context.link_to(m.course.title, meetup_path(m)) },
                :'marker-color' => '#79BD9A',
                :'marker-symbol' => 'library',
                :'marker-size' => 'medium'
              }
            }
        end

        render json: @geojson
      end
      
    end

  end
end
