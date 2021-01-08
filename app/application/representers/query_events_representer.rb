# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'query_event_representer'
# require_relative 'event_representer'

module IndieLand
  module Representer
    # Represents list of projects for API output
    class QueryEvents < Roar::Decorator
      include Roar::JSON

      collection :query_events, extend: Representer::QueryEvent, class: OpenStruct
    end
  end
end
