# frozen_string_literal: true
require 'queries_watch/current'

module QueriesWatch
  class Subscriber < ActiveSupport::Subscriber
    COLORS = {
      info: ActiveSupport::LogSubscriber::CYAN,
      warn: ActiveSupport::LogSubscriber::YELLOW,
      error: ActiveSupport::LogSubscriber::RED,
    }

    def sql(event)
      return if event.payload[:name] == 'SCHEMA'

      log = event.payload.slice(:name, :sql, :cached).merge(duration: event.duration)
      Current.logs << log
    end

    def self.flush
      summary = Current.summary
      level = Current.level
      name = ActiveSupport::LogSubscriber.new.send(:color, 'Queries', COLORS.fetch(level), true)
      message = "#{name} total_count: #{summary.total_count}, cached_count: #{summary.cached_count}, exec_count: #{summary.exec_count}, total_duration: #{summary.total_duration}"
      Rails.logger.public_send(level, message) if summary.total_count > 0
    end
  end
end
