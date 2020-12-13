# frozen_string_literal: true

require_relative 'future_today_events'

module Views
  # View Object Future Dates
  class FutureEvents
    def initialize(future_events)

      @future_events_dates = []
      future_events.each do |daily_events|
        @future_events_dates.push(daily_events.date)
      end

      @future_events = future_events.map.with_index do |daily_events, index|
        TodayEvents.new(daily_events.date,daily_events.daily_events, index)
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
