class User < ActiveRecord::Base
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable

  attr_accessible :notice, :active, :uid, :name, :provider, :access_token, :link, :version

  has_many :user_events
  has_many :events, :through => :user_events

  validates :name,         :presence => true, :length => {:maximum => 255}
  validates :uid,          :presence => true
  validates :provider,     :presence => true
  validates :access_token, :presence => true
  validates :link,         :presence => true
  validates :version,      :presence => true

  before_destroy :delete_organized_event
  after_commit :delete_permission, on: :destroy

  class << self
    def find_or_create_with_auth_hash(auth_hash)
      if user = find_with_auth_hash(auth_hash)
        user.update_attributes(access_token: auth_hash.credentials.token)
      else
        user = create_with_auth_hash(auth_hash)
      end
      user
    end

    def find_with_auth_hash(auth_hash)
      User.where(provider: auth_hash.provider, uid: auth_hash.uid).first
    end

    def create_with_auth_hash(auth_hash)
      access_token = auth_hash.credentials.token
      version = GraphAPI.version(access_token)
      user = User.new( 
        notice:       true,
        uid:          auth_hash.uid,
        name:         auth_hash.extra.raw_info.name,
        provider:     auth_hash.provider,
        link:         auth_hash.extra.raw_info.link,
        access_token: access_token,
        version:      version
      )
      user.save!
      user
    end
  end

  def activate
    self.update_attributes(active: true) unless self.active?
  end

  def active?
    case self.active
    when "true", "t", true then true
    else false
    end
  end

  def notice?
    case notice
    when "true", "t", true then true
    else false
    end
  end

  private

  def delete_permission
    GraphAPI.delete_permissions(access_token)
  end

  def delete_organized_event
    events.each {|event| event.destroy }
  end
end
