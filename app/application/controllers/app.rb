# frozen_string_literal: true

require 'roda'
require 'net/http'
require 'json'

# Routing entry
module IndieLand
  # Main routing rules
  # :reek:RepeatedConditional
  class App < Roda
    logger = AppLogger.instance.get

    plugin :halt
    plugin :flash
    plugin :public, root: 'app/presentation/public' # Use public folder as location of files
    plugin :hash_routes

    plugin :render, views: './app/presentation/views/', escape: true
    plugin :assets, path: './app/presentation/assets/', css: ['style.css']
    compile_assets
    # rubocop:disable Metrics/BlockLength
    route do |routing|
      routing.public
      routing.assets
      routing.hash_routes

      routing.root do
        session[:user] ||= ''
        @title = 'home'
        logger.info("User #{session[:user]} enter")
        # deal with user sessions
        result = Service::TrackUser.new.call(user_id: session[:user], logger: logger)
        if result.failure?
          flash.now[:error] = result.failure
          login_number = 0
        else
          session[:user] = result.value![:user_id]
          login_number = result.value![:login_number]
        end

        result = Service::GetEvents.new.call(logger: logger)
        flash.now[:error] = result.failure if result.failure?
        future_events = result.value!.range_events

        viewable_events = Views::FutureEvents.new(future_events)
        view 'home/index', locals: {
          future_events: viewable_events,
          login_number: login_number
        }
      end

      routing.on 'events' do
        routing.get 'search' do
          response['Content-Type'] = 'application/json'
          eventname = routing.params["q"]
          sresult = Service::SearchEvents.new.call(eventname)
          events = sresult.value!
          # result = Gateway::IndieLandApi.new(IndieLand::App.config).search(eventname)                      
          # puts(events)
          # response.status 200
          events
        end
      end

      routing.on 'event' do
        routing.get Integer do |event_id|
          result = Service::EventSessions.new.call(event_id)
          flash.now[:error] = result.failure if result.failure?
          event_sessions = result.value!

          viewable_event_sessions = Views::EventSessionsList.new(event_sessions)
          @website = viewable_event_sessions.website
          @title = 'event'
          view 'event/index', locals: {
            sessions: viewable_event_sessions
          }
        end
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
