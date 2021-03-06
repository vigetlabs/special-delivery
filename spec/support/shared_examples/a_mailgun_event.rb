shared_examples "a Mailgun event" do
  describe "#issue_callback" do
    context "if a message-id is provided" do
      subject { described_class.new('message-id' => '<123@test.com>') }

      context "if a Delivery is found with the provided message id" do
        let(:delivery) { double('delivery') }

        before do
          SpecialDelivery::Delivery.stub(:find_by_message_id!).with('<123@test.com>').and_return(delivery)
        end

        it "sends #callback to the delivery" do
          delivery.should_receive(:callback).with(mailgun_event_type)

          subject.issue_callback
        end
      end

      context "if no Delivery is found with the provided message id" do
        it "raises a RecordNotFound error" do
          expect {
            subject.issue_callback
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "if no message-id is provided" do
      subject { described_class.new({}) }

      it "raises an error" do
        expect {
          subject.issue_callback
        }.to raise_error(KeyError)
      end
    end
  end
end
