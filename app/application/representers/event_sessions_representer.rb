# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'session_representer'

module IndieLand
  module Representer
    # Represents event information for API output
    class EventSessions < Roar::Decorator
      include Roar::JSON

      property :event_id
      property :event_name
      property :event_website
      property :description
      property :sale_website
      property :event_ticket_website
      property :source
      collection :sessions, extend: Representer::Session, class: OpenStruct
    end
  end
end
