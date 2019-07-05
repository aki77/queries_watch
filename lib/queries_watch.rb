require 'queries_watch/version'
require 'queries_watch/railtie'
require 'queries_watch/configuration'

module QueriesWatch
  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
