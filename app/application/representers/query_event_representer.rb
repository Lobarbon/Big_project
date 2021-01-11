# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

module IndieLand
  module Representer
    # Represents event information for API output
    class QueryEvent < Roar::Decorator
      include Roar::JSON
      include Roar::Hypermedia
      include Roar::Decorator::HypermediaConsumer

      property :event_id
      property :event_name

      link :self do
        "#{App.config.API_HOST}/api/v1/events/#{event_id}"
      end

      link :comment do
        "#{App.config.API_HOST}/api/v1/comments/#{event_id}"
      end

      private

      def event_id
        represented.event_id
      end

      def event_name
        represented.event_name
      end
    end
  end
end
