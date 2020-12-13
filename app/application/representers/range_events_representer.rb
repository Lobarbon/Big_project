# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'daily_events_representer'

module IndieLand
  module Representer
    # Represents list of projects for API output
    class RangeEvents < Roar::Decorator
      include Roar::JSON

      collection :range_events, extend: Representer::DailyEvents, class: OpenStructWithLinks
    end
  end
end
