# frozen_string_literal: true

require_relative 'future_today_events'

module Views
  # View Object Future Dates
  # :reek:DuplicateMethodCall
  class Like
    def initialize(event)
        @event = event
    end

    def id
        @event.event_id
    end

    def like_num
        @event.like_num
    end
  end
end
