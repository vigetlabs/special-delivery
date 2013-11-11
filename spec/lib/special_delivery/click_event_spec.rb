require 'spec_helper'

describe SpecialDelivery::ClickEvent do
  it_behaves_like "a Mailgun event" do
    let(:mailgun_event_type) { :click }
  end
end
