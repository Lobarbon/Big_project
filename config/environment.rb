# frozen_string_literal: true

require 'roda'
require 'yaml'
require 'econfig'
require 'delegate'

module IndieLand
  # Configuration for the App
  class App < Roda
    plugin :environments

    extend Econfig::Shortcut
    Econfig.env = environment.to_s
    Econfig.root = '.'

    use Rack::Session::Cookie, secret: config.SESSION_SECRET
  end
end
