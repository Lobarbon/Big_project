# frozen_string_literal: true

require 'dry/transaction'

module IndieLand
  module Service
    # Analyzes contributions to a project
    # :reek:InstanceVariableAssumption
    # :reek:TooManyStatements
    # :reek:UncommunicativeVariableName
    # :reek:FeatureEnvy
    # :reek:DuplicateMethodCall
    # :reek:UtilityFunction
    class CommentEvent
      include Dry::Transaction

      step :add_comment
      step :reify_comment

      private

      # rubocop:disable Lint/MissingCopEnableDirective
      # rubocop:disable Metrics/AbcSize
      # get json data from api
      def add_comment(input)
        input[:logger].info('Calling Indie Land api and get json')
        input[:response] = Gateway::IndieLandApi.new(IndieLand::App.config)
                                                .add_comment(input)
        input[:response].success? ? Success(input) : Failure(input[:response].message)
      rescue StandardError => e
        input[:logger].error(e.backtrace.join("\n"))
        Failure('Error occurs at calling Indie Land Api')
      end

      # make json back into an object
      def reify_comment(input)
        unless input[:response].processing?
          Representer::CommentStatus.new(OpenStruct.new)
                                    .from_json(input[:response].payload)
        end
        Success(input)
      rescue StandardError
        Failure('Error in our events report  -- please try again')
      end
    end
  end
end
