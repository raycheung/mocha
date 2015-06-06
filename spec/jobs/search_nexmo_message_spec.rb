require 'rails_helper'

RSpec.describe SearchNexmoDeliveredMessage, type: :job do
  let(:nexmo_delivery_receipt) { FactoryGirl.create(:nexmo_delivery_receipt) }
  let(:message_content) do
    {
      "body" => "message body",
      "type" => "MT",
      "date-received" => "2015-06-06",
      "final-status" => "DELIVERD",
      "date-closed" => "2015-06-06",
      "latency" => "521"
    }
  end

  describe '#perform' do
    it 'searches for the message on Nexmo' do
      expect_any_instance_of(Nexmo::Client).to receive(:get_message).and_return(message_content)

      SearchNexmoDeliveredMessage.new(nexmo_delivery_receipt.id).perform
    end
  end
end
