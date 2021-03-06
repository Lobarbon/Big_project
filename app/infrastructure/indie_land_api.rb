# frozen_string_literal: true

require_relative 'list_request'
require 'http'

module IndieLand
  module Gateway
    # Infrastructure to call IndieLand API
    class Api
      def initialize(config)
        @config = config
        @request = Request.new(@config)
      end

      def alive?
        @request.get_root.success?
      end

      def events_list(list)
        @request.events_list(list)
      end

      # HTTP request transmitter
      # :reek:TooManyStatements
      # :reek:UtilityFunction
      class Request
        def initialize(config)
          @api_host = config.API_HOST
          @api_root = "#{@api_host}/api/v1"
        end

        def get_root # rubocop:disable Naming/AccessorMethodName
          call_api('get')
        end

        def events_list(list)
          call_api('get', ['events'],
                   'list' => Value::WatchedList.to_encoded(list))
        end

        private

        def params_str(params)
          params.map { |key, value| "#{key}=#{value}" }.join('&')
                .then { |str| str ? "?#{str}" : '' }
          params.to_s
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
      # :reek:IrresponsibleModule
      class Response < SimpleDelegator
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
