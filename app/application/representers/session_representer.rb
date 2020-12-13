# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

module IndieLand
  module Representer
    # Represents event information for API output
    class Session < Roar::Decorator
      include Roar::JSON

      property :event_id
      property :session_id
      property :start_time
      property :end_time
      property :address
      property :place
      property :ticket_price
    end
  end
end
