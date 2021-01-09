# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'comment_representer'

module IndieLand
  module Representer
    # Represents Comments
    class Comments < Roar::Decorator
      include Roar::JSON

      property :event_id
      collection :comments, extend: Representer::Comment, class: OpenStruct
    end
  end
end
