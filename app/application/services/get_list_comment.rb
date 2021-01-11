# frozen_string_literal: true

require 'dry/transaction'

module IndieLand
  module Service
    # :reek:InstanceVariableAssumption
    # :reek:TooManyStatements
    # :reek:UncommunicativeVariableName
    # :reek:FeatureEnvy
    # :reek:DuplicateMethodCall
    # Analyzes sessions to a event
    class ListComment
      # Analyzes sessions to a event
      include Dry::Transaction

      # step :validate_evnets
      step :retrieve_events
      step :reify_events

      private

      # rubocop:disable Lint/MissingCopEnableDirective
      # rubocop:disable Metrics/AbcSize
      # get json data from api
      def retrieve_events(input)
        input[:logger].info('Calling Indie Land api and get json')
        input[:response] = Gateway::IndieLandApi.new(IndieLand::App.config)
                                                .list_event_comments(input[:event_id])
        input[:response].success? ? Success(input) : Failure(input[:response].message)
      rescue StandardError => e
        input[:logger].error(e.backtrace.join("\n"))
        Failure('Error occurs at calling Indie Land Api comment')
      end

      # make json back into an object
      def reify_events(input)
        unless input[:response].processing?
          Representer::Comments.new(OpenStruct.new)
                               .from_json(input[:response].payload)
                               .then { Success(input) }
        end
        Success(input)
      rescue StandardError
        Failure('Error in our comments event report  -- please try again')
      end
    end
  end
end
