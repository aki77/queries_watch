# frozen_string_literal: true

module QueriesWatch
  module Helpers
    def queries_watch_summary
      summary = Current.summary
      messaage = "%c[Queries] %ctotal_count: #{summary.total_count}, cached_count: #{summary.cached_count}, exec_count: #{summary.exec_count}, total_duration: #{summary.total_duration}"
      logs = Current.logs.map do |log|
        log.merge(duration: log[:duration].round(2))
      end

      javascript_tag <<~JS
        if (console && console.groupCollapsed) {
          console.#{Current.level}('#{messaage}', 'font-weight: bold', '')
          console.groupCollapsed()
          console.table(#{logs.to_json})
          console.groupEnd()
        }
      JS
    end
  end
end
