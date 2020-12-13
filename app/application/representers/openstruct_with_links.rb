# frozen_string_literal: true

<<<<<<< HEAD
module CodePraise
  module Response
    # OpenStruct for deserializing json with hypermedia
=======
module IndieLand
  module Representer
    # OpenStruct for deserializing json with hypermedia
    # :reek:Attribute
>>>>>>> app_only_you
    class OpenStructWithLinks < OpenStruct
      attr_accessor :links
    end
  end
end
