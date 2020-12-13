# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'member_representer'

# Represents essential Repo information for API output
module IndieLand
  module Representer
    # Represent a Project entity as Json
    class Event < Roar::Decorator
      include Roar::JSON
      include Roar::Hypermedia
      include Roar::Decorator::HypermediaConsumer

      property :origin_id
      property :event_name

      link :self do
        "#{App.config.API_HOST}/api/v1/events/#{event_id}"
      end

      private

      def event_id
        represented.id
      end
    end
  end
end
