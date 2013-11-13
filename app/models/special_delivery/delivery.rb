module SpecialDelivery
  class Delivery < ActiveRecord::Base
    belongs_to :deliverable, polymorphic: true

    validates :callback_class_name, :message_id, :presence => true

    def callback(event_type)
      callback_class.send(event_type, deliverable) if callback_class
    end

    private

    def callback_class
      callback_class_name.constantize
    rescue NameError
    end
  end
end
