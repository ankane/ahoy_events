require "ahoy_events/version"
require "ahoy_matey"
require "ahoy/tracker"
require "ahoy/subscribers/active_record"

module AhoyEvents
  class Engine < ::Rails::Engine
  end
end

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
