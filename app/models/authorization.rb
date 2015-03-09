class Authorization < ActiveRecord::Base
  belongs_to :user
  belongs_to :provider
  validates :provider, :uid, presence: true

  def self.find_by_oauth_credentials(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    credentials = Authorization.where(:provider=> Provider.find_by(name: provider)).where(:uid => uid).first
  end

  def self.find_or_create(auth_hash)
    unless auth = find_by_oauth_credentials(auth_hash)
      user = User.find(current_user.id)
      provider = Provider.find_by(name: auth_hash[:provider])
      auth = create :user => self, :provider => provider, :uid => auth_hash[:uid]
    end

    auth
  end
end
