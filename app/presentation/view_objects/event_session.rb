# frozen_string_literal: true

require 'time'

module Views
  # :reek:RepeatedConditional
  # :reek:UncommunicativeVariableName

  # View for a single session entity
  class Session
    def initialize(session, index = nil)
      @session = session
      @index = index
    end

    def id
      @index
    end

    def start_time
      d = DateTime.parse(@session.start_time)
      d.strftime('%Y-%m-%d')
    end

    def end_time
      d = DateTime.parse(@session.end_time)
      d.strftime('%Y-%m-%d')
    end

    def address
      @session.address
    end

    def place
      @session.place
    end
  end
end
