require 'spec_helper'

describe SpecialDelivery::BounceEvent do
  it_behaves_like "a Mailgun event" do
    let(:mailgun_event_type) { :bounce }
  end
end
