# frozen_string_literal: true

module QueriesWatch
  class Current < ActiveSupport::CurrentAttributes
    attribute :logs

    resets { self.logs = [] }

    def initialize
      super
      self.logs = []
    end

    def summary
      total_count = logs.size
      cached_count = logs.count { |log| log[:cached] }
      exec_count = total_count - cached_count
      total_duration = '%.1fms' % logs.sum { |log| log[:duration] }

      OpenStruct.new({ total_count: total_count, cached_count: cached_count, exec_count: exec_count, total_duration: total_duration }).freeze
    end

    def level
      error_threshold = QueriesWatch.configuration.error_threshold || Float::INFINITY
      warn_threshold = QueriesWatch.configuration.warn_threshold || Float::INFINITY

      case logs.count { |log| !log[:cached] }
      when error_threshold..Float::INFINITY
        :error
      when warn_threshold..Float::INFINITY
        :warn
      else
        :info
      end
    end
  end
end
