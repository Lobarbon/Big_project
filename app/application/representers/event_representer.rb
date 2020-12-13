# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

<<<<<<< HEAD
require_relative 'member_representer'

=======
>>>>>>> app_only_you
# Represents essential Repo information for API output
module IndieLand
  module Representer
    # Represent a Project entity as Json
    class Event < Roar::Decorator
      include Roar::JSON
      include Roar::Hypermedia
      include Roar::Decorator::HypermediaConsumer

<<<<<<< HEAD
      property :origin_id
      property :event_name

      link :self do
        "#{App.config.API_HOST}/api/v1/events/#{event_id}"
=======
      property :event_id
      property :event_name
      property :session_id

      link :self do
        "/api/v1/events/#{event_id}/sessions/#{session_id}"
>>>>>>> app_only_you
      end

      private

      def event_id
<<<<<<< HEAD
        represented.id
=======
        represented.event_id
      end

      def session_id
        represented.session_id
>>>>>>> app_only_you
      end
    end
  end
end
