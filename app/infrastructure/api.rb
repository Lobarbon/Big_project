# frozen_string_literal: true

# require_relative 'list_request'
require 'http'

module IndieLand
  module Gateway
    # :reek:UncommunicativeVariableName
    # :reek:RepeatedConditional
    # :reek:FeatureEnvy
    # :reek:DataClump
    # :reek:UncommunicativeVariableName

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

      def event_likes(event_id)
        @request.get_likes(event_id)
      end

      def search(event_name)
        @request.get_search_events(event_name)
      end

      def add_comment(input)
        @request.add_comment(input)
      end

      def add_like(event_id)
        @request.add_like(event_id)
      end

      def search_events(event_name)
        @request.get_search_events(event_name)
      end

      def list_event_comments(event_id)
        @request.get_list_event_comments(event_id)
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

        def get_events(_input)
          call_api('get', ['events'])
        end

        def get_sessions(event_id)
          call_api('get', ['events', event_id])
        end

        def get_likes(event_id)
          call_api('get', ['likes', event_id])
        end

        def get_search_events(event_name)
          call_search_api('get', ['events/search', event_name])
        end

        def add_comment(input)
          call_comment_api('post', ['comments', input[:event_id], input[:comment]])
        end

        def add_like(event_id)
          call_api('post', ['likes', event_id])
        end

        def get_list_event_comments(event_id)
          call_api('get', ['comments', event_id])
        end

        private

        def params_str(params)
          params.map { |key, value| "#{key}=#{value}" }.join('&')
        end

        def call_api(method, resources = [], params = {})
          api_path = resources.empty? ? @api_host : @api_root
          url = [api_path, resources].flatten.join('/') + params_str(params)
          puts(url)
          HTTP.headers('Accept' => 'application/json').send(method, url)
              .then { |http_response| Response.new(http_response) }
        rescue StandardError
          raise "Invalid URL request: #{url}"
        end

        def call_search_api(method, resources = [], _params = {})
          api_path = resources.empty? ? @api_host : @api_root
          url = "#{api_path}/#{resources[0]}?q=#{resources[1]}"
          HTTP.headers('Accept' => 'application/json').send(method, url)
              .then { |http_response| Response.new(http_response) }
        rescue StandardError
          raise "Invalid URL request: #{url}"
        end

        def call_comment_api(method, resources = [], _params = {})
          api_path = resources.empty? ? @api_host : @api_root
          url = "#{api_path}/#{resources[0]}/#{resources[1]}?q=#{resources[2]}"
          puts url
          HTTP.headers('Accept' => 'application/json').send(method, url)
              .then { |http_response| Response.new(http_response) }
        rescue StandardError
          raise "Invalid URL request: #{url}"
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

          def processing?
            code == 202
          end

          def message
            payload['message']
            # JSON.parse(payload)['message']
          end

          def payload
            body.to_s
          end
        end
      end
    end
  end
end
