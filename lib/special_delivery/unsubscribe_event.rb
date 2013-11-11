module SpecialDelivery
  class UnsubscribeEvent < BaseEvent

    private

    def callback_method
      :unsubscribe
    end
  end
end
