require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  before { request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(Rails.application.secrets.api_token) }

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

  describe '#create' do
    let(:hash) do
      {
        messages: [
          { body: "在嗎", sender: "85293806050", recipient: "system", received_at: "2015-07-08 10:42:34 +0800"},
          { body: "可以比個號碼我確認嗎~?", sender: "system", recipient: "85293806050", received_at: "2015-07-08 10:56:38 +0800"},
          { body: "反光..睇唔清", sender: "system", recipient: "85293806050", received_at: "2015-07-08 10:56:45 +0800"},
          { body: "你好，上午查詢，但還未收到", sender: "85233667711", recipient: "system", received_at: "2015-07-08 16:03:54 +0800"},
          { body: "呢D服務態度，冇人應😠", sender: "system", recipient: "85293806050", received_at: "2015-07-08 16:03:54 +0800"}
        ]
      }
    end

    it 'stores the payload containing generic messages' do
      expect(ProcessGenericMessagesJob).to receive(:perform_later).with(an_instance_of(String))

      expect { post :create, hash, format: :json }.to change { GenericMessagesRequest.count }.by(1)
      expect(response).to have_http_status(:success)
    end
  end
end
