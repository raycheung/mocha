require 'rails_helper'

RSpec.describe TwilioWebhookController, type: :controller do
  after { expect(response.status).to eq(200) }

  describe '#message_callback' do
    let(:query_hash) do
      {
        "MessageSid" => "SM1d3acc1bd23b4c1c804acabaf9d21c84",
        "SmsSid" => "SM1d3acc1bd23b4c1c804acabaf9d21c84",
        "AccountSid" => "ACdd97bf82b69136067317b819977d7941",
        "From" => "+85264522710",
        "To" => "+85264522710",
        "Body" => "你好嗎!",
        "MessageStatus" => "delivered"
      }
    end

    it 'saves the message status' do
      expect { post :status_callback, query_hash }.to change { TwilioMessageReceipt.count }.by(1)

      im = TwilioMessageReceipt.last
      expect(im.message_sid).not_to be_blank
      expect(im.to_number).not_to be_blank
      expect(im.body).not_to be_blank
      expect(im.message_status).not_to be_blank
    end
  end

  describe '#inbound' do
    let(:query_hash) do
      {
        "MessageSid" => "SM1d3acc1bd23b4c1c804acabaf9d21c84",
        "SmsSid" => "SM1d3acc1bd23b4c1c804acabaf9d21c84",
        "AccountSid" => "ACdd97bf82b69136067317b819977d7941",
        "From" => "+85264522710",
        "To" => "+85264522710",
        "Body" => "你好嗎!"
      }
    end

    it 'records the inbound message' do
      expect { get :inbound, query_hash }.to change { TwilioInboundMessage.count }.by(1)

      im = TwilioInboundMessage.last
      expect(im.message_sid).not_to be_blank
      expect(im.from_number).not_to be_blank
      expect(im.body).not_to be_blank
    end
  end
end
