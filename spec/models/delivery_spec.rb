require 'spec_helper'

describe SpecialDelivery::Delivery do
  describe "validations" do
    it { should belong_to(:deliverable) }
    it { should validate_presence_of(:callback_class_name) }
    it { should validate_presence_of(:message_id) }
  end

  describe "#callback" do
    let(:deliverable_class) { double('class', :primary_key => 'id', :base_class => ActiveRecord::Base) }
    let(:deliverable) { double('deliverable', :[] => 1, :class => deliverable_class) }
    subject { described_class.new(:callback_class_name => 'CallbackClass',
                                  :deliverable         => deliverable,
                                  :message_id          => '<1234@test.com>') }

    context "when a callback class exists" do
      before do
        CallbackClass = Class.new
      end

      context "and responds to the callback method" do
        before do
          CallbackClass.class_eval do
            define_singleton_method(:bounce) {}
          end
        end

        it "sends the callback message to the callback class" do
          CallbackClass.should_receive(:bounce).with(deliverable)

          subject.callback(:bounce)
        end
      end

      context "but does not respond to the callback method" do
        it "does not raise an error" do
          expect {
            subject.callback(:complaint)
          }.to_not raise_error
        end
      end
    end

    context "when no callback class exists" do
      it "does not raise an error" do
        expect {
          subject.callback(:bounce)
        }.to_not raise_error
      end
    end
  end
end
