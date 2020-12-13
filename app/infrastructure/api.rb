# frozen_string_literal: true

# require_relative 'list_request'
require 'http'

module IndieLand
  module Gateway
    # Infrastructure to call Indie Land API
    class IndieLandApi
      def initialize(config)
        @config = config
        @request = Request.new(@config)
      end

      def alive?
        @request.get_root.success?
      end

      def events(input)
        @request.get_events(input)
      end

      def event_sessions(event_id)
        @request.get_sessions(event_id)
      end

      # HTTP request transmitter
      # :reek:DuplicateMethodCall
      # :reek:UtilityFunction
      # :reek:TooManyStatements
      class Request
        def initialize(config)
          @api_host = config.API_HOST
          @api_root = "#{config.API_HOST}/api/v1"
        end

        def get_root # rubocop:disable Naming/AccessorMethodName
          call_api('get')
        end

        def get_events(input)
          call_api('get', ['events'])
        end

        def get_sessions(event_id)
          call_api('get', ['events', event_id])
        end

        private

        def params_str(params)
          params.map { |key, value| "#{key}=#{value}" }.join('&')
                .then { |str| str ? "?#{str}" : '' }
        end

        def call_api(method, resources = [], params = {})
          api_path = resources.empty? ? @api_host : @api_root
          url = [api_path, resources].flatten.join('/') + params_str(params)
          HTTP.headers('Accept' => 'application/json').send(method, url)
              .then { |http_response| Response.new(http_response) }
        rescue StandardError
          raise "Invalid URL request: #{url}"
        end
      end

      # Decorates HTTP responses with success/error
      # :reek:TooManyStatements
      class Response < SimpleDelegator
        # Define error
        NotFound = Class.new(StandardError)

        SUCCESS_CODES = (200..299).freeze

        def success?
          code.between?(SUCCESS_CODES.first, SUCCESS_CODES.last)
        end

        def message
          payload['message']
        end

        def payload
          body.to_s
        end
      end
    end
  end
end
