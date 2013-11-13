module SpecialDelivery
  class UnsubscribeEvent < BaseEvent

    private

    def callback_method
      :unsubscribed
    end
  end
end
