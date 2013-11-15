module SpecialDelivery
  class Callback
    def bounced(*args); end
    def clicked(*args); end
    def complained(*args); end
    def delivered(*args); end
    def dropped(*args); end
    def opened(*args); end
    def unsubscribed(*args); end

    def evaluate
      if callback_argument.nil?
        send(callback_method)
      else
        send(callback_method, callback_argument)
      end
    end

    def self.respond_to?(method, include_private = false)
      super || public_instance_methods(true).include?(method)
    end

    def self.method_missing(method_name, *args)
      if respond_to?(method_name)
        new(method_name, *args).evaluate
      else
        super
      end
    end

    private

    attr_reader :callback_argument, :callback_method

    def initialize(callback_method, *args)
      @callback_method = callback_method
      @callback_argument = args[0].presence
    end
  end
end
