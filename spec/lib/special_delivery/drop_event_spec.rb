require 'spec_helper'

describe SpecialDelivery::DropEvent do
  it_behaves_like "a Mailgun event" do
    let(:mailgun_event_type) { :drop }
  end
end
