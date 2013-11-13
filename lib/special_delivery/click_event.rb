module SpecialDelivery
  class ClickEvent < BaseEvent

    private

    def callback_method
      :clicked
    end
  end
end
