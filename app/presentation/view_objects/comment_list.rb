# frozen_string_literal: true

require_relative 'future_today_events'

module Views
  # View Object Future Dates
  # :reek:DuplicateMethodCall
  class CommentList
    def initialize(event)
      @event = JSON.parse(event)['event_id']
      @re_event = []
      @event['comments'].reverse_each { |comment| @re_event.append(comment) }

      @comment_list = @re_event.map do |comment|
        Comment.new(comment)
      end
    end

    def each(&block)
      @comment_list.each(&block)
    end

    def any?
      @comment_list.any?
    end
  end
end
