# frozen_string_literal: true

require_relative 'event_session'

# hello
module Views
  # View for sessions entity
  class EventSessionsList
    def initialize(event)
      @event = event
      @sessions = event.sessions.map { |session| Session.new(session) }
    end

    def event_name
      @event.event_name
    end

    def date
      @sessions[0].start_time
    end

    def website
      @event.event_website
    end

    def each(&block)
      @sessions.each(&block)
    end
  end
end
