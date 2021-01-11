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
    class LikeEvent
      include Dry::Transaction

      step :add_like
      step :reify_like

      private

      # get json data from api
      def add_like(event_id)
        # input[:logger].info('Calling Indie Land api and get json')
        result = Gateway::IndieLandApi.new(IndieLand::App.config)
                                      .add_like(event_id)
        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError => e
        puts "#{e.inspect}\\n#{e.backtrace}"
        # input[:logger].error(e.backtrace.join("\n"))
        Failure('Error occurs at calling Indie Land Api')
      end

      # make json back into an object
      def reify_like(event_like_json)
        Representer::Like.new(OpenStruct.new)
                         .from_json(event_like_json)
                         .then { |event_like| Success(event_like) }
      rescue StandardError
        Failure('Error in our events report  -- please try again')
      end
    end
  end
end
