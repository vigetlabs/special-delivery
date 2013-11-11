require 'spec_helper'

describe SpecialDelivery::DeliveryEvent do
  it_behaves_like "a Mailgun event" do
    let(:mailgun_event_type) { :delivery }
  end
end
