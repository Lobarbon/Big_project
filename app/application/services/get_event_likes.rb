# frozen_string_literal: true

require 'dry/transaction'

module IndieLand
  module Service
    # Analyzes likes to a event
    # :reek:InstanceVariableAssumption
    # :reek:TooManyStatements
    # :reek:UncommunicativeVariableName
    # :reek:FeatureEnvy
    # :reek:DuplicateMethodCall
    class ListLikes
      include Dry::Transaction

      # step :find_events_from_api
      step :retrieve_event_likes
      step :reify_event_likes

      private

      # get json data from api
      def retrieve_event_likes(event_id)
        # input[:logger].info('Calling Indie Land api and get json')
        result = Gateway::IndieLandApi.new(IndieLand::App.config)
                                      .event_likes(event_id)
        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError => e
        puts "#{e.inspect}\\n#{e.backtrace}"
        # input[:logger].error(e.backtrace.join("\n"))
        Failure('Error occurs at calling Indie Land Api')
      end

      # make json back into an object
      def reify_event_likes(event_likes_json)
        Representer::Like.new(OpenStruct.new)
                                  .from_json(event_likes_json)
                                  .then { |event_likes| Success(event_likes) }
      rescue StandardError
        Failure('Error in our events report  -- please try again')
      end
    end
  end
end
