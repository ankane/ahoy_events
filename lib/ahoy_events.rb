require "ahoy_events/version"
require "ahoy_matey"
require "ahoy_events/engine"
require "ahoy/tracker"
require "ahoy/subscribers/active_record"

module Ahoy
  mattr_accessor :subscribers
  self.subscribers = []
end

module Ahoy
  module Controller

    protected

    def ahoy
      @ahoy ||= Ahoy::Tracker.new(controller: self)
    end

  end
end
