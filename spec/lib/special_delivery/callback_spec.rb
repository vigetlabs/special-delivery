require 'spec_helper'

describe SpecialDelivery::Callback do
  describe "event callback methods" do
    [
      :bounced,
      :clicked,
      :complained,
      :delivered,
      :dropped,
      :opened,
      :unsubscribed
    ].each do |event|
      describe "##{event}" do
        it "returns nil" do
          described_class.send(event).should == nil
        end
      end
    end
  end

  describe "#evaluate" do
    context "when the callback instance has an argument" do
      subject { described_class.send(:new, :unsubscribed, 'argument') }

      it "calls the callback method with the argument" do
        subject.should_receive(:unsubscribed).with('argument')

        subject.evaluate
      end
    end

    context "when the callback instance has no argument" do
      subject { described_class.send(:new, :unsubscribed) }

      it "calls the callback method" do
        subject.should_receive(:unsubscribed)

        subject.evaluate
      end
    end
  end

  describe ".respond_to?" do
    context "when the method is defined as an instance method" do
      it "returns true" do
        described_class.respond_to?(:opened).should == true
      end
    end

    context "when the method is not defined as an instance method" do
      it "returns true" do
        described_class.respond_to?(:trashed).should == false
      end
    end
  end

  describe ".method_missing" do
    context "with a method it responds to" do
      let(:callback) { double('Callback', :evaluate => true) }

      it "instantiates a Callback" do
        described_class.should_receive(:new).with(:opened, 'argument').and_return(callback)

        described_class.method_missing(:opened, 'argument')
      end

      it "sends #evaluate to the new Callback instance" do
        described_class.stub(:new).with(:opened, 'argument').and_return(callback)
        callback.should_receive(:evaluate)

        described_class.method_missing(:opened, 'argument')
      end
    end

    context "with a method it does not respond to" do
      it "delegates to super" do
        ::Object.should_receive(:method_missing).with(:trashed, 'argument')

        described_class.method_missing(:trashed, 'argument')
      end
    end
  end
end
