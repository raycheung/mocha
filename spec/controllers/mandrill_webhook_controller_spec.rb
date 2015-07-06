require 'rails_helper'

RSpec.describe MandrillWebhookController, type: :controller do
  describe "POST #message_event" do
    let(:post_params) do
      {
        "mandrill_events" => "[{\"event\":\"send\",\"msg\":{\"ts\":1436166540,\"subject\":\"the email subject\",\"email\":\"ray.swc@gmail.com\",\"tags\":[],\"opens\":[],\"clicks\":[],\"state\":\"sent\",\"smtp_events\":[],\"subaccount\":null,\"resends\":[],\"reject\":null,\"sender\":\"donotreply@mocha.mandrillapp.com\",\"template\":\"template-tc\"},\"ts\":1436166540}]"
      }
    end

    it "records the message event for later processing" do
      expect_any_instance_of(ProcessMandrillMessageEvents).to receive(:perform)

      expect { post :message_event, post_params }.to change { MandrillMessageEventRequest.count }.by(1)
      expect(response).to have_http_status(:success)

      r = MandrillMessageEventRequest.last
      expect(r.mandrill_events).to be_a(String)
      events = JSON.parse(r.mandrill_events)
      expect(events.size).to eq(1)
    end

    context "if missing the `mandrill_events` param" do
      let(:post_params) { { } }

      it "responds as a bad request" do
        expect_any_instance_of(ProcessMandrillMessageEvents).not_to receive(:perform)

        expect { post :message_event, post_params }.not_to change { MandrillMessageEventRequest.count }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "if there is no event" do
      let(:post_params) { { "mandrill_events" => "[]" } }

      it "responds as a bad request" do
        expect_any_instance_of(ProcessMandrillMessageEvents).not_to receive(:perform)

        expect { post :message_event, post_params }.not_to change { MandrillMessageEventRequest.count }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

end
