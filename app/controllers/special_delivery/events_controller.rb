require_dependency "special_delivery/application_controller"

module SpecialDelivery
  class EventsController < ApplicationController
    skip_before_filter :verify_authenticity_token

    before_filter :ensure_authenticity

    rescue_from ActiveRecord::RecordNotFound,
                :with => :issue_accepted_response

    def create
      event.issue_callback
      render_nothing(:ok)
    end

    private

    def issue_accepted_response
      render_nothing(:accepted)
    end

    def render_nothing(http_status)
      render nothing: true, status: http_status
    end

    def ensure_authenticity
      Authenticator.new(params).authentic? || render_nothing(:unauthorized)
    end

    def event
      @event ||= EventFactory.new_event(params)
    end
  end
end
