module SpecialDelivery
  class DropEvent < BaseEvent

    private

    def callback_method
      :drop
    end
  end
end
