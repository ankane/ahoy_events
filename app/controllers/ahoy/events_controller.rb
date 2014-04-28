module Ahoy
  class EventsController < Ahoy::BaseController

    def create
      ahoy.track params[:name], params[:properties]
      render json: {}
    end

  end
end
