require 'rails_helper'

RSpec.describe NexmoWebhookController, type: :controller do
  describe '#dlr_callback' do
    let(:query_hash) do
      {
        "to" => "WeLend.hk",
        "network-code" => "45406",
        "messageId" => "0200000065A28CFC",
        "msisdn" => "85293806050",
        "status" => "delivered",
        "err-code" => "0",
        "price" => "0.02080000",
        "scts" => "1506061003",
        "message-timestamp" => "2015-06-06+10%3A03%3A25",
        "client-ref" => "ray.cheung@welab.co"
      }
    end

    it 'records the delivery receipt' do
      expect(Delayed::Job).to receive(:enqueue).with(an_instance_of(SearchNexmoDeliveredMessage))

      expect { get :dlr_callback, query_hash }.to change { NexmoDeliveryReceipt.count }.by(1)
      expect(response.status).to eq(200)

      dr = NexmoDeliveryReceipt.last
      expect(dr.to).to eq "WeLend.hk"
      expect(dr.msisdn).to eq "85293806050"
      expect(dr.status).to eq "delivered"
    end
  end
end
