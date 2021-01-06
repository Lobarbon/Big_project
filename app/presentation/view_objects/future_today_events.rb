# frozen_string_literal: true

require_relative 'future_event_brief_hashes'

module Views
  # View for today events entity
  class TodayEvents
    def initialize(date, events, index = nil)
      @index = index
      @events = events.map.with_index { |brief_hash, id| BriefHashes.new(brief_hash, id, date) }
      @date = date
    end

    def date_html_id
      "date[#{@index}]"
    end

    def date
      @date
    end

    def each(&block)
      @events.each(&block)
    end

    def any?
      @events.any?
    end
  end
end
