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
    class ListComment
      include Dry::Transaction

      # step :validate_evnets
      step :retrieve_events
      step :reify_events

      private

      # get json data from api
      def retrieve_events(input)
        input[:logger].info('Calling Indie Land api and get json')
        result = Gateway::IndieLandApi.new(IndieLand::App.config)
                                      .list_event_comments(input[:event_id])
        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError => e
        input[:logger].error(e.backtrace.join("\n"))
        Failure('Error occurs at calling Indie Land Api comment')
      end

      # make json back into an object
      def reify_events(comments_json)
        # Success(events_json)
        Representer::Comments.new(OpenStruct.new)
                                .from_json(comments_json)
                                .then { |comments_json| Success(comments_json) }
      rescue StandardError
        Failure('Error in our comments event report  -- please try again')
      end
    end
  end
end
