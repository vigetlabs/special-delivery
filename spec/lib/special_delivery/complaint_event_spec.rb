require 'spec_helper'

describe SpecialDelivery::ComplaintEvent do
  it_behaves_like "a Mailgun event" do
    let(:mailgun_event_type) { :complained }
  end
end
