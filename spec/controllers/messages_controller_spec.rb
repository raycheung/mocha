require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe '#index' do
    let!(:outbound) { FactoryGirl.create_list(:nexmo_delivery_receipt, 3, :full, msisdn: '85293806050', status: 'delivered') }
    let!(:inbound) { FactoryGirl.create_list(:nexmo_inbound_message, 2, :concat, msisdn: '85293806050') }
    let!(:outbound_others) { FactoryGirl.create_list(:nexmo_delivery_receipt, 2, :full, msisdn: '85261213770', status: 'delivered') }
    let!(:inbound_others) { FactoryGirl.create_list(:nexmo_inbound_message, 3, :concat, msisdn: '85261213770') }

    render_views

    context 'if no mobile is provided' do
      it 'returns 400' do
        get :index, mobile: '', format: :json
        expect(response.status).to eq(400)
      end
    end

    context 'if no message for the mobile number' do
      it 'returns empty array' do
        get :index, mobile: '85235906396', format: :json
        expect(assigns[:nexmo_messages].count).to eq(0)
        expect(response.status).to eq(200)
      end
    end

    it 'searches for both inbound and outbound messages within 14 days' do
      get :index, mobile: '85293806050', format: :json
      expect(assigns[:nexmo_messages].count).to eq(5)
      expect(response.status).to eq(200)

      json = JSON.parse(response.body)
      expect(json.count).to eq(5)
    end
  end
end
