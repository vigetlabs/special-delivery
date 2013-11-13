module SpecialDelivery
  class BounceEvent < BaseEvent

    private

    def callback_method
      :bounced
    end
  end
end
