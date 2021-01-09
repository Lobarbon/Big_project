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
        @title = 'home'
        session[:user] ||= ''
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
          logger.info("User #{session[:user]} enter")
          event_name = routing.params["q"]
          result = Service::SearchEvents.new.call(event_name: event_name, logger: logger)
          search_events = result.value!.query_events
          
          viewable_events = Views::QueryEvents.new(search_events)

          view 'search/index', locals: {
            query_events: viewable_events,
            event_name: event_name
          }
        end
      end

      routing.on 'event' do
        @title = 'event'
        routing.get Integer do |event_id|
          # event session
          event_result = Service::EventSessions.new.call(event_id)
          flash.now[:error] = event_result.failure if event_result.failure?
          event_sessions = event_result.value!
          viewable_event_sessions = Views::EventSessionsList.new(event_sessions)
          @website = viewable_event_sessions.website
          
          comments_result = Service::ListComment.new.call(event_id: event_id, logger: logger)
          event_comments = comments_result.value!.event_id
          viewable_event_comments = Views::CommentList.new(event_comments)
        
          view 'event/index', locals: {
            sessions: viewable_event_sessions,
            comments: viewable_event_comments
          }
        end
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
