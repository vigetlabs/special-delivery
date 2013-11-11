module SpecialDelivery
  class BaseEvent
    attr_reader :params

    def initialize(params)
      @params = params || {}
    end

    def issue_callback
      delivery.callback(callback_method)
    end

    private

    def callback_method
      raise NotImplementedError, 'Event subclasses must implement #callback_method'
    end

    def delivery
      @delivery ||= Delivery.find_by_message_id!(params.fetch('Message-Id'))
    end
  end
end
