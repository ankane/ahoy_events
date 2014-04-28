module Ahoy
  class Tracker

    def initialize(options = {})
      @controller = options[:controller]
    end

    def track(name, properties, options = {})
      # publish to each subscriber
      if @controller
        options[:controller] ||= @controller
      end
      if @controller.respond_to?(:current_user)
        options[:user] ||= @controller.current_user
      end
      if @controller.respond_to?(:current_visit)
        options[:visit] ||= @controller.current_visit
      end
      options[:time] ||= Time.zone.now

      subscribers = Ahoy.subscribers
      if subscribers.any?
        subscribers.each do |subscriber|
          subscriber.track(name, properties, options)
        end
      else
        $stderr.puts "No subscribers"
      end
    end

  end
end
