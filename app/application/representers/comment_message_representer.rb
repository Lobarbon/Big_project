# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

module IndieLand
  module Representer
    # Represents Comments
    class CommentMessage < Roar::Decorator
      include Roar::JSON

      property :request_id
    end
  end
end
