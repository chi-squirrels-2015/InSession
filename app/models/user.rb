
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :meetup_memberships
  has_many :meetups, through: :meetup_memberships
  has_many :organized_meetups, class_name: "Meetup", foreign_key: :organizer_id
  has_many :course_memberships
  has_many :courses, through: :course_memberships
  has_many :questions
  has_many :responses

  has_many :authorizations
  validates :first_name, :email, :presence => true #lines 2 and 3 are from tutsplus tutorial
  validates :last_name, :email, :presence => true  #lines 2 and 3 are from tutsplus tutorial

  def add_provider(auth_hash)
    # Check if the provider already exists, so we don't add it twice
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end
  end

  # require 'oauth/request_proxy/typhoeus_request'
  def self.test_request
    token = "t6480427084414976" # The user token from the Credentials
    secret = "ebHgCUXVBmfmtqpQ" # The user secret from the Credentials
    oauth_token = OAuth::Token.new(token, secret)


    consumer = OAuth::Consumer.new("UHze9rM6n5NtNee2", "f9Z24DkmGTyWZx5E", site: "http://www.khanacademy.org/api/v1")
    oauth_params = {:consumer => consumer, :token => oauth_token}

    uri = URI("http://www.khanacademy.org/api/v1/user/playlists")
    req = Net::HTTP::Get.new(uri)


    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      req.oauth!(http, consumer, oauth_token)
      http.request(req)
    end

    puts res.body

    # hydra = Typhoeus::Hydra.new
    # req = Typhoeus::Request.new("http://www.khanacademy.org/api/v1/user/playlists") # :method needs to be specified in options
    # oauth_helper = OAuth::Client::Helper.new(req, oauth_params.merge(:request_uri => "/user/playlists"))
    # req.options[:headers].merge!({"Authorization" => oauth_helper.header}) # Signs the request
    # hydra.queue(req)
    # hydra.run
    # puts req.response
  end

end
