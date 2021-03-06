class Event < ApplicationRecord
    belongs_to :creator, :class_name => 'User'
    has_many :event_attendees, :foreign_key => "attended_event_id", :class_name => "EventAttendee"
    has_many :attendees, :through => :event_attendees, source: "attendee" 

    scope :upcoming_events, -> { where("date > ?", Date.current) }
    scope :past_events, -> { where("date < ?", Date.current) }
end
