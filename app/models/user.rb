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

  def self.oauth_request(params)
    token = "t6480427084414976"                                   # The user token from the Credentials
    secret = "ebHgCUXVBmfmtqpQ"                                   # The user secret from the Credentials
    oauth_token = OAuth::Token.new(token, secret)
    #                               Our Site Key        Our Site Secret           Our Site Stub
    consumer = OAuth::Consumer.new("UHze9rM6n5NtNee2", "f9Z24DkmGTyWZx5E", site: "http://www.khanacademy.org/api/v1")

    oauth_params = {:consumer => consumer, :token => oauth_token}

    uri = URI("http://www.khanacademy.org/api/v1/user/playlists") # This is the url that we want to pull data from


    req = Net::HTTP::Get.new(uri)                                 # This is the GET request

    response = Net::HTTP.start(uri.hostname, uri.port) do |http|  # This is processing the request
      req.oauth!(http, consumer, oauth_token)                     # .oauth! call which formats the request
      http.request(req)                                           # The actual http request is made here
    end

    puts response.body                                            # <Net::HTTPOK:0x007f88b30485b0> body content
  end
end
