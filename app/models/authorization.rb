class Authorization < ActiveRecord::Base
  belongs_to :user
  belongs_to :provider
  validates :provider, :uid, presence: true

  def self.find_or_create(auth_hash)
    unless auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      user = User.find(current_user.id)
      auth = create user: user, provider: auth_hash["provider"], uid: auth_hash["uid"]
    end

    auth
  end
end
