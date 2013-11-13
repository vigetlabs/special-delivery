module SpecialDelivery
  class ComplaintEvent < BaseEvent

    private

    def callback_method
      :complained
    end
  end
end
