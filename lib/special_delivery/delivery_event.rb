module SpecialDelivery
  class DeliveryEvent < BaseEvent

    private

    def callback_method
      :delivered
    end
  end
end
