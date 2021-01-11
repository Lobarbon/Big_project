# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

module IndieLand
  module Representer
    # Represents Comments
    class Comment < Roar::Decorator
      include Roar::JSON

      property :event_id
      property :comment
    end
  end
end
