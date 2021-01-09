# frozen_string_literal: true

require_relative 'future_today_events'

module Views
  # View Object Future Dates
  # :reek:DuplicateMethodCall
  class QueryEvent
    def initialize(query_event, index)
      @index = index
      @query_event = query_event
    end

    def index
      @index
    end

    def any?
      @future_events.any?
    end
  end
end
