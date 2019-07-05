# frozen_string_literal: true

module QueriesWatch
  class Railtie < Rails::Railtie
    initializer 'initialize_queries_watch', after: 'active_support.reset_all_current_attributes_instances' do |app|
      require 'queries_watch/subscriber'
      Subscriber.attach_to :active_record

      app.executor.to_complete(prepend: true) do
        Subscriber.flush
      end
    end

    ActiveSupport.on_load :action_view do
      require 'queries_watch/helpers'
      include Helpers
    end
  end
end
