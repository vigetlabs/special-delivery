require 'pry'

module EmailCallback
  class SomeEmail
    def self.bounce
      'bounce event callback'
    end

    def self.open
      'open event callback'
    end
  end
end
