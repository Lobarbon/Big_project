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
    class EventSessions
      include Dry::Transaction

      # step :find_events_from_api
      step :retrieve_event_sessions
      step :reify_event_sessions

      private

      # get json data from api
      def retrieve_event_sessions(event_id)
        # input[:logger].info('Calling Indie Land api and get json')
        result = Gateway::IndieLandApi.new(IndieLand::App.config)
                                      .event_sessions(event_id)
        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError => e
        # input[:logger].error(e.backtrace.join("\n"))
        Failure('Error occurs at calling Indie Land Api')
      end

      # make json back into an object
      def reify_event_sessions(event_sessions_json)
        Representer::EventSessions.new(OpenStruct.new)
                                .from_json(event_sessions_json)
                                .then { |event_sessions| Success(event_sessions) }
      rescue StandardError
        Failure('Error in our events report  -- please try again')
      end
    end
  end
end
