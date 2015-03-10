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
  end

  def self.oauth_request
  end

  #GEOCODER
  def full_street_address
    [street_address, city, state, zip].compact.join(', ')
  end

  def name
    [first_name, last_name].join(' ')
  end
end
