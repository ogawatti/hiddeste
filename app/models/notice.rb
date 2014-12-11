class Notice < ActiveRecord::Base
  attr_accessible :event_id
  belongs_to :event

  validates :event_id, :presence => true
end
