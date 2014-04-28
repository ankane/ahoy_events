module Ahoy
  class Event < ActiveRecord::Base
    belongs_to :visit
    belongs_to :user, polymorphic: true

    serialize :properties, JSON
  end
end
