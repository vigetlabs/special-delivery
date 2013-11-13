require "spec_helper"
require "support/sample_resource"

describe SomeMailer do
  describe ".some_email" do
    let(:resource) { SampleResource.new }
    let(:delivery) { double('Delivery') }

    it "calls creates a Delivery with the proper parameters" do
      SampleResource.stub(:find) { resource }
      SecureRandom.stub(:uuid) { 'messageid' }

      SpecialDelivery::Delivery.should_receive(:new).and_return(delivery)
      delivery.should_receive(:callback_class_name=).with('EmailCallback::SomeEmail')
      delivery.should_receive(:deliverable=).with(resource)
      delivery.should_receive(:message_id=).with('<messageid>')
      delivery.should_receive(:save)

      described_class.some_email.deliver
    end
  end
end
