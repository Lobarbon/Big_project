# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'event_representer'

# Represents essential Repo information for API output
module IndieLand
  module Representer
    # Represent a Project entity as Json
    class DailyEvents < Roar::Decorator
      include Roar::JSON

      property :date
      collection :daily_events, extend: Representer::Event, class: OpenStruct
    end
  end
end
