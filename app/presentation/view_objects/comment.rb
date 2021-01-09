# frozen_string_literal: true

require_relative 'future_today_events'

module Views
  # View Object Future Dates
  # :reek:DuplicateMethodCall
  class Comment
    def initialize(comment, index = nil)
      @comment = comment
    end

    def comment
      @comment["comment"]
    end
  end
end
