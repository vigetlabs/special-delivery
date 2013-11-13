module SpecialDelivery
  class DropEvent < BaseEvent

    private

    def callback_method
      :dropped
    end
  end
end
