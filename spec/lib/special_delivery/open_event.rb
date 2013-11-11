require 'spec_helper'

describe SpecialDelivery::OpenEvent do
  it_behaves_like "a Mailgun event" do
    let(:mailgun_event_type) { :open }
  end
end
