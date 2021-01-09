# frozen_string_literal: true

require 'date'
require 'json'

module IndieLand
  # Api routes
  class App
    hash_branch 'api' do |routing|
      routing.on 'events' do
        response['Content-Type'] = 'application/json; charset=utf-8'

        # Event id find info
        routing.on 'id' do
          routing.get Integer do |event_id|
            event = IndieLand::Repository::Events.find_id(event_id)
            event.nil? ? '' : event.to_attr_hash.to_json
          end
          routing.get do
            events = IndieLand::Repository::Events.find_all
            events.map(&:to_attr_hash).to_json
          end
        end

        # Events date find info
        routing.on 'date' do
          @future_events = IndieLand::Repository::Events.future_events
          routing.get Integer, Integer, Integer do |yy, mm, dd|
            date = Date.new(yy, mm, dd)
            @future_events.events_on_this_date(date).to_json
          end

          routing.get do
            @future_events.future_dates.to_json
          end
        end

        # Events date find info
        routing.on 'search' do
          routing.get do
            query = CGI.unescape(routing.params)
            puts query
            events = IndieLand::Repository::Events.query_events(query)
            events.nil? ? '' : events.map(&:to_attr_hash).to_json
          end
        end

        # # Load previously viewed projects
        # routing.on 'viewobj' do
        #   future_events = IndieLand::Repository::Events.future_events
        #   viewable_events = Views::FutureEvents.new(future_events)

        #   view 'room/session', locals: { future_events: viewable_events }
        # end
      end
    end
  end
end
