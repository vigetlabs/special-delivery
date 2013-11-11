module SpecialDelivery
  class EventFactory
    EVENT_TYPE_CLASSES = {
        'opened'       => OpenEvent,
        'unsubscribed' => UnsubscribeEvent,
        'complained'   => ComplaintEvent,
        'bounced'      => BounceEvent,
        'clicked'      => ClickEvent,
        'dropped'      => DropEvent,
        'delivered'    => DeliveryEvent
      }

    def self.new_event(event_params)
      event_type = event_params.fetch(:event)

      EVENT_TYPE_CLASSES.fetch(event_type).new(event_params)
    end
  end
end
