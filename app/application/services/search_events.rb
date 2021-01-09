# frozen_string_literal: true

require 'dry/transaction'

module IndieLand
  module Service
    # Analyzes sessions to a event
    # :reek:InstanceVariableAssumption
    # :reek:TooManyStatements
    # :reek:UncommunicativeVariableName
    # :reek:FeatureEnvy
    # :reek:DuplicateMethodCall
    class SearchEvents
      include Dry::Transaction

      # step :validate_evnets
      step :retrieve_events
      step :reify_events

      private

      # get json data from api
      def retrieve_events(input)
        input[:logger].info('Calling Indie Land api and get json')
        result = Gateway::IndieLandApi.new(IndieLand::App.config)
                                      .search(input[:eventname])
        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError => e
        input[:logger].error(e.backtrace.join("\n"))
        Failure('Error occurs at calling Indie Land Api')
      end

      # make json back into an object
      def reify_events(events_json)
        # Success(events_json)
        Representer::QueryEvents.new(OpenStruct.new)
                                .from_json(events_json)
                                .then { |query_events| Success(query_events) }
      rescue StandardError
        Failure('Error in our events report  -- please try again')
      end
    end
  end
end
