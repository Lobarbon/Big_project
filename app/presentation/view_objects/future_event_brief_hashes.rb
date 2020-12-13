# frozen_string_literal: true

module Views
  # View for a single event entity
  class BriefHashes
    def initialize(brief_hash, index = nil)
      @brief_hash = brief_hash
      @index = index
    end

    def event_html_id
      "event[#{@index}].block"
    end

    def event_href
      "room/#{event_id}"
    end

    def event_html_link_id
      "event[#{@index}].link"
    end

    def event_id
      @brief_hash[:event_id]
    end

    def event_name
      @brief_hash[:event_name]
    end

    def session_id
      @brief_hash[:session_id]
    end
  end
end
