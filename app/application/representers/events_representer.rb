# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'openstruct_with_links'
require_relative 'event_representer'

module IndieLand
  module Representer
    # Represents list of projects for API output
    class EventsList < Roar::Decorator
      include Roar::JSON

      collection :events,
                 extend: Representer::Event,
                 class: Response::OpenStructWithLinks
    end
  end
end
