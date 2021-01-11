# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

module IndieLand
  module Representer
    # Represents Comments
    class CommentStatus < Roar::Decorator
      include Roar::JSON

      property :status
      collection :message, extend: Representer::CommentMessage, class: OpenStruct
    end
  end
end
