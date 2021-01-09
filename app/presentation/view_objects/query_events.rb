# frozen_string_literal: true

require_relative 'future_today_events'

module Views
  # View Object Future Dates
  # :reek:DuplicateMethodCall
  class QueryEvents
    def initialize(query_events)
      @future_events_dates = []

      @query_events = query_events.map.with_index do |query_event, index|
        QueryEvent.new(query_event, index)
      end
    end

    def each(&block)
      @future_events.each(&block)
    end

    def any?
      @future_events.any?
    end
  end
end
