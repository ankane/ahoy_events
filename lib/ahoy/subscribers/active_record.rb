module Ahoy
  module Subscribers
    class ActiveRecord

      def track(name, properties, options = {})
        Ahoy::Event.create! do |e|
          e.visit = options[:visit]
          e.user = options[:user]
          e.name = name
          e.properties = properties
          e.time = options[:time]
        end
      end

    end
  end
end
