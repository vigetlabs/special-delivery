module SpecialDelivery
  class ComplaintEvent < BaseEvent

    private

    def callback_method
      :complaint
    end
  end
end
