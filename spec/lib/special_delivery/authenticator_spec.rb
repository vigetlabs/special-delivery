require 'spec_helper'

describe SpecialDelivery::Authenticator do
  describe "#authentic?" do
    subject { described_class.new(params) }

    context "when passed good authenticity params" do
      let(:params) do
        {
          'timestamp' => 1234567890,
          'token'     => 'mailgun-token',
          'signature' => '37241b06e1b1b1bed3499b9634a376b1f7b1d6f7d1412a4e045d9aec5f01d0fc'
        }
      end

      it "returns true" do
        subject.authentic?.should == true
      end
    end

    context "when passed bad authenticity params" do
      let(:params) do
        {
          'timestamp' => 1234567890,
          'token'     => 'mailgun-token',
          'signature' => 'unauthentic-signature'
        }
      end

      it "returns false" do
        subject.authentic?.should == false
      end
    end

    context "when not passed the required params" do
      let(:params) do
        { 'dolan' => 'pls' }
      end

      it "returns false" do
        subject.authentic?.should == false
      end
    end
  end
end
