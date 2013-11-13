require 'pry'

module EmailCallback
  class SomeEmail < SpecialDelivery::Callback
    def bounced
      'bounce event callback'
    end

    def opened
      'open event callback'
    end
  end
end
