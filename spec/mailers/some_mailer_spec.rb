require "spec_helper"

describe SomeMailer do
  before do
    SampleResource = Class.new
  end

  describe ".some_email" do
    let(:resource) { SampleResource.new }

    it "calls creates a Delivery with the proper parameters" do
      SampleResource.stub(:find) { resource }
      SecureRandom.stub(:uuid) { 'messageid' }

      SpecialDelivery::Delivery.should_receive(:create).with({
        :callback_class_name => 'EmailCallback::SomeEmail',
        :deliverable         => resource,
        :message_id          => '<messageid>'
      })

      described_class.some_email.deliver
    end
  end
end
