# frozen_string_literal: true

module Views
  # View for a single event entity
  class BriefHashes
    def initialize(brief_hash, index = nil, date = nil)
      @brief_hash = brief_hash
      @index = index
      @date = date
    end

    def event_html_id
      "event[#{@index}].block"
    end

    def event_href
      "event/#{event_id}"
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

    def event_description
      @brief_hash[:description]
    end

    def event_date
      @date
    end

    def session_id
      @brief_hash[:session_id]
    end
  end
end
