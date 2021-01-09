# frozen_string_literal: true

require_relative 'future_today_events'

module Views
  # View Object Future Dates
  # :reek:DuplicateMethodCall
  class QueryEvents
    def initialize(query_events)
      @query_events = query_events.map do |query_event|
        QueryEvent.new(query_event)
      end
    end

    def each(&block)
      @query_events.each(&block)
    end

    def any?
      @query_events.any?
    end
  end
end
