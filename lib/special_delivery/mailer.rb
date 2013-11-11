module SpecialDelivery
  module Mailer
    def special_delivery(params = {}, &block)
      callback_class = params[:callback_class]

      yield.tap do |mail|
        if mail && callback_class
          Delivery.create(
            :callback_class_name => callback_class.to_s,
            :deliverable         => params[:callback_record],
            :message_id          => message_id_for(mail))
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
