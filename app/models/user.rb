class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :meetup_memberships
  has_many :meetups, through: :meetup_memberships
  has_many :organized_meetups, class_name: "Meetup", foreign_key: :organizer_id
  has_many :user_exercises
  has_many :exercises, through: :user_exercises
  # has_many :course_memberships
  # has_many :courses, through: :course_memberships


  has_many :questions
  has_many :responses

  has_many :authorizations
  validates :first_name, :email, :presence => true #lines 2 and 3 are from tutsplus tutorial
  validates :last_name, :email, :presence => true  #lines 2 and 3 are from tutsplus tutorial

  # GEOCODER
  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  def add_provider(auth_hash)
    # Check if the provider already exists, so we don't add it twice
    unless authorizations.find_by_oauth_credentials(auth_hash)
      provider = Provider.find_by(name: auth_hash[:provider])
      Authorization.create :user => self, :provider => provider, :uid => auth_hash[:uid], :user_token => auth_hash.credentials[:token], :user_secret => auth_hash.credentials[:secret]
    end
  end

  def oauth_request(auth_hash, url_stub)
    provider = Provider.find_by("name" => auth_hash["provider"])
    oauth_token = auth_hash["extra"].access_token
    consumer = auth_hash["extra"]["access_token"].consumer
    full_url = provider.site + url_stub
    uri = URI(full_url) # This is the url that we want to pull data from
    req = Net::HTTP::Get.new(uri)
    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      req.oauth!(http, consumer, oauth_token)
      http.request(req)
    end
    # puts response.body
    if response.code == "200"
      response
    else
      puts "Fuck Off!"
    end
  end

  def self.oauth_request
    secret = "ebHgCUXVBmfmtqpQ"                                   # The user secret from the Credentials
    token = "t6480427084414976"                                   # The user token from the Credentials
    oauth_token = OAuth::Token.new(token, secret)
    #                               Our Site Key        Our Site Secret           Our Site Stub
    consumer = OAuth::Consumer.new("UHze9rM6n5NtNee2", "f9Z24DkmGTyWZx5E", site: "http://www.khanacademy.org/api/v1")
    uri = URI("http://www.khanacademy.org/api/v1/user/playlists") # This is the url that we want to pull data from


    req = Net::HTTP::Get.new(uri)                                 # This is the GET request

    response = Net::HTTP.start(uri.hostname, uri.port) do |http|  # This is processing the request
      req.oauth!(http, consumer, oauth_token)                     # .oauth! call which formats the request
      http.request(req)                                           # The actual http request is made here
    end
    puts response.body                                            # <Net::HTTPOK:0x007f88b30485b0> body content
  end

  #GEOCODER
  def full_street_address
    [street_address, city, state, zip].compact.join(', ')
  end

  def name
    [first_name, last_name].join(' ')
  end  

end
