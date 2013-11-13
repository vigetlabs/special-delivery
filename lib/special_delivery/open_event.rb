module SpecialDelivery
  class OpenEvent < BaseEvent

    private

    def callback_method
      :opened
    end
  end
end
