module SpecialDelivery
  class BounceEvent < BaseEvent

    private

    def callback_method
      :bounce
    end
  end
end
