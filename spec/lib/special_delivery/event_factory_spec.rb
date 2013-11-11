require 'spec_helper'

describe SpecialDelivery::EventFactory do
  describe ".new_event" do
    context "when an event is provided" do
      it "instantiates an Event object of the proper type" do
        SpecialDelivery::BounceEvent.should_receive(:new).with({ :event => 'bounced' })

        described_class.new_event({ :event => 'bounced' })
      end

      it "returns an Event object" do
        event = double('BounceEvent')
        SpecialDelivery::BounceEvent.stub(:new).with({ :event => 'bounced' }).and_return(event)

        described_class.new_event({ :event => 'bounced' }).should == event
      end
    end

    context "when no event is provided" do
      it "raises an error" do
        expect {
          described_class.new_event({})
        }.to raise_error(KeyError)
      end
    end
  end
end
