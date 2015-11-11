class Authentication < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true, uniqueness: true

  def self.create_from_omniauth(omniauth)
    self.create!(provider: omniauth.provider, uid: omniauth.uid)
  end
end
