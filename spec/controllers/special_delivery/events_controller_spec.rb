require 'spec_helper'

describe SpecialDelivery::EventsController do
  describe "POST #create" do
    context "with valid authenticity parameters" do
      let(:params) {
        {
          "Message-Id" => "<abc123@test.com>",
          "event"      => "opened",
          "token"      => "mailgun-token",
          "timestamp"  => "1234567890",
          "signature"  => "37241b06e1b1b1bed3499b9634a376b1f7b1d6f7d1412a4e045d9aec5f01d0fc" # valid signature
        }
      }

      context "with message params not corresponding to a persisted Delivery object" do
        it "responds with status 202" do
          post :create, params.merge({ :use_route => :special_delivery })

          response.status.should == 202
        end
      end

      context "with message params corresponding to a persisted Delivery object" do
        before do
          SpecialDelivery::Delivery.create(
            :callback_class_name => 'EmailCallback::SomeEmail',
            :message_id          => '<abc123@test.com>')
        end

        it "calls the callback specified by the delivery Object and event type" do
          EmailCallback::SomeEmail.should_receive(:opened)

          post :create, params.merge({ :use_route => :special_delivery })
        end

        it "responds with status 200" do
          post :create, params.merge({ :use_route => :special_delivery })

          response.status.should == 200
        end
      end
    end

    context "with invalid authenticity parameters" do
      let(:params) {
        {
          "Message-Id" => "<abc123@test.com>",
          "event"      => "opened",
          "token"      => "mailgun-token",
          "timestamp"  => "1234567890",
          "signature"  => "unauthentic-signature"
        }
      }

      it "responds with status 401" do
        post :create, params.merge({ :use_route => :special_delivery })

        response.status.should == 401
      end
    end
  end
end
