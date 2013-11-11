module SpecialDelivery
  class DeliveryEvent < BaseEvent

    private

    def callback_method
      :delivery
    end
  end
end
