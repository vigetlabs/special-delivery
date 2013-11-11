module SpecialDelivery
  class Authenticator
    def initialize(event_params)
      @event_params = event_params.to_hash
    end

    def authentic?
      actual_signature == expected_signature
    rescue
      false
    end

    private

    attr_reader :event_params

    def expected_signature
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha256'), api_key,"#{timestamp}#{token}")
    end

    def api_key
      MAILGUN_CONFIG[:api_key]
    end

    def timestamp
      event_params.fetch('timestamp')
    end

    def token
      event_params.fetch('token')
    end

    def actual_signature
      event_params.fetch('signature')
    end
  end
end