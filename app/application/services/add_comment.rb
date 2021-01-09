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
      step :reify_event_sessions

      private

      # get json data from api
      def add_comment(input)
        # input[:logger].info('Calling Indie Land api and get json')
        result = Gateway::IndieLandApi.new(IndieLand::App.config)
                                      .add_comment(input)
        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError => e
        puts "#{e.inspect}\\n#{e.backtrace}"
        # input[:logger].error(e.backtrace.join("\n"))
        Failure('Error occurs at calling Indie Land Api')
      end

      # make json back into an object
      def reify_event_sessions(event_comments_json)
        puts event_comments_json
        Success(event_comments_json)
        # Representer::Comments.new(OpenStruct.new)
        #                           .from_json(event_comments_json)
        #                           .then { |event_comments| Success(event_comments) }
      rescue StandardError
        Failure('Error in our events report  -- please try again')
      end
    end
  end
end
