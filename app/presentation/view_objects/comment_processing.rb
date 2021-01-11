# frozen_string_literal: true

module Views
  # :reek:RepeatedConditional
  # View object to capture progress bar information
  class CommentProcessing
    def initialize(config, response)
      if response.nil?
        @response = ""
      else
        @response = JSON.parse(response)
      end

      
      @config = config
    end

    def in_progress?
      @response["status"] == "processing" ? true : false
    end

    def ws_channel_id
      @response['message']['request_id'] if in_progress?
    end

    def ws_javascript
      "#{@config.API_HOST}/faye/faye.js" if in_progress?
    end

    def ws_route
      "#{@config.API_HOST}/faye/faye" if in_progress?
    end
  end
end
