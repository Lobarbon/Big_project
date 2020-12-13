# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

# Represents essential Repo information for API output
module IndieLand
  module Representer
    # Represent a Project entity as Json
    class Event < Roar::Decorator
      include Roar::JSON
      include Roar::Hypermedia
      include Roar::Decorator::HypermediaConsumer

      property :event_id
      property :event_name
      property :session_id

      link :self do
        "/api/v1/events/#{event_id}/sessions/#{session_id}"
      end

      private

      def event_id
        represented.event_id
      end

      def session_id
        represented.session_id
      end
    end
  end
end
