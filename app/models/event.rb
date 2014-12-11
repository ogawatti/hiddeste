class Event < ActiveRecord::Base
  attr_accessible :date, :description, :name, :organizer_id, :place

  has_many :user_events, :dependent => :destroy
  has_many :users, :through => :user_events
  has_many :notices, :order => 'created_at DESC', :dependent => :destroy

  validates :name, :presence => true, :length => {:maximum => 255}
  validates :organizer_id, :presence => true

  after_create :create_user_event

  def organizer
    User.find_by_id(self.organizer_id)
  end

  def organizer_name
    User.find_by_id(self.organizer_id).name
  end

  def notice_users
    users.select{|user| user.notice? }
  end

  def og_description
    [ "Place: #{place}", "Date: #{date}", "Description: #{description}" ].join(", ")
  end

  private

  def create_user_event
    user_event = UserEvent.new
    user_event.user_id  = self.organizer_id
    user_event.event_id = self.id
    user_event.save
  end
end
