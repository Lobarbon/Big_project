# frozen_string_literal: true

require_relative 'future_today_events'

module Views
  # View Object Future Dates
  # :reek:DuplicateMethodCall
  class CommentList
    def initialize(comment_list)
      @comment_list = comment_list["comments"].map do |comment|
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
