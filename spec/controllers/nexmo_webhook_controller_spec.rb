require 'rails_helper'

RSpec.describe NexmoWebhookController, type: :controller do
  after { expect(response.status).to eq(200) }

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

    context 'if messageId is missing' do
      it 'does nothing' do
        query_hash.delete("messageId")
        expect { get :dlr_callback, query_hash }.not_to change { NexmoDeliveryReceipt.count }
      end
    end

    it 'records the delivery receipt' do
      # FIXME: somehow mocking :enqueue doesn't work, expect on the :perform
      # expect(Delayed::Job).to receive(:enqueue).with(an_instance_of(SearchNexmoDeliveredMessage))
      expect_any_instance_of(SearchNexmoDeliveredMessage).to receive(:perform)

      expect { get :dlr_callback, query_hash }.to change { NexmoDeliveryReceipt.count }.by(1)

      dr = NexmoDeliveryReceipt.last
      expect(dr.to).to eq "WeLend.hk"
      expect(dr.msisdn).to eq "85293806050"
      expect(dr.status).to eq "delivered"
    end
  end

  describe '#inbound' do
    let(:query_hash) do
      {
        "type" => "WeLend.hk",
        "to" => "0200000065A28CFC",
        "msisdn" => "85293806050",
        "messageId" => "delivered",
        "message-timestamp" => "2015-06-06+10%3A03%3A25",
        "text" => "asdfjahsdfkhasdjkbkvbajkfdjkalsdhf",
        "keyword" => "asdfjahsdfkhasdjkbkvbajkfdjkalsdhf",
        "concat" => "false",
        "concat-ref" => "iasdfasdfsad",
        "concat-total" => "1",
        "concat-part" => "1"
      }
    end

    context 'if messageId is missing' do
      it 'does nothing' do
        query_hash.delete("messageId")
        expect { get :inbound, query_hash }.not_to change { NexmoInboundMessage.count }
      end
    end

    it 'records the inbound message' do
      expect { get :inbound, query_hash }.to change { NexmoInboundMessage.count }.by(1)
      expect(response.status).to eq(200)

      im = NexmoInboundMessage.last
      expect(im.message_id).not_to be_blank
      expect(im.msisdn).not_to be_blank
      expect(im.text).not_to be_blank
    end
  end
end
