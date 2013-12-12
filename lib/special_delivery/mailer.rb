module SpecialDelivery
  module Mailer
    def special_delivery(params = {})
      callback_class = params[:callback_class]

      yield.tap do |mail|
        if mail && callback_class
          Delivery.new.tap do |delivery|
            delivery.callback_class_name = callback_class.to_s
            delivery.deliverable = params[:callback_record] if params[:callback_record]
            delivery.message_id = message_id_for(mail)
          end.save
        end
      end
    end

    private

    def message_id_for(mail)
      if mail.message_id.blank?
        mail.message_id = SecureRandom.uuid
      end

      "<#{mail.message_id}>"
    end
  end
end
