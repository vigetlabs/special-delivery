require 'spec_helper'

describe SpecialDelivery::UnsubscribeEvent do
  it_behaves_like "a Mailgun event" do
    let(:mailgun_event_type) { :unsubscribe }
  end
end
