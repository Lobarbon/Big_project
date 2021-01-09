# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

module IndieLand
  module Representer
    # Represents Comments
    class Like < Roar::Decorator
      include Roar::JSON

      property :event_id
      property :like_num
    end
  end
end
