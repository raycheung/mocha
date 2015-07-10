require 'rails_helper'

RSpec.describe ProcessMandrillMessageEvents, type: :job do
  let(:mandrill_events) do
    "[{\"event\":\"send\",\"_id\":\"c5155433e50548e8b5b3bf3b91ec7aee\",\"msg\":{\"ts\":1436166540,\"subject\":\"the email subject\",\"email\":\"ray.swc@gmail.com\",\"tags\":[],\"opens\":[],\"clicks\":[],\"state\":\"sent\",\"smtp_events\":[],\"subaccount\":null,\"resends\":[],\"reject\":null,\"sender\":\"donotreply@mocha.mandrillapp.com\",\"template\":\"template-tc\"},\"ts\":1436166540}]"
  end
  let(:mandrill_request) { MandrillMessageEventRequest.create(mandrill_events: mandrill_events) }

  describe '#perform' do
    it 'digests the raw mandrill request into multiple events' do
      expect { ProcessMandrillMessageEvents.new(mandrill_request.id).perform }.to change { MandrillMessageEvent.count }.by(1)

      expect(MandrillMessageEvent.last.msg["subject"]).to eq("the email subject")
      expect { MandrillMessageEventRequest.find(mandrill_request.id) }.to raise_error(Mongoid::Errors::DocumentNotFound)
    end

    # By experiment, Mandrill may send the same event more than once
    context "when the same event arrives again" do
      let(:mandrill_events_again) do
        "[{\"event\":\"send\",\"_id\":\"c5155433e50548e8b5b3bf3b91ec7aee\",\"msg\":{\"ts\":1436166540,\"subject\":\"the email subject (updated)\",\"email\":\"ray.swc@gmail.com\",\"tags\":[],\"opens\":[],\"clicks\":[],\"state\":\"sent\",\"smtp_events\":[],\"subaccount\":null,\"resends\":[],\"reject\":null,\"sender\":\"donotreply@mocha.mandrillapp.com\",\"template\":\"template-tc\"},\"ts\":1436166540}]"
      end
      let(:mandrill_request_again) { MandrillMessageEventRequest.create(mandrill_events: mandrill_events_again) }

      before { ProcessMandrillMessageEvents.new(mandrill_request.id).perform }

      it 'always get the updated event' do
        expect { ProcessMandrillMessageEvents.new(mandrill_request_again.id).perform }.not_to change { MandrillMessageEvent.count }

        expect(MandrillMessageEvent.last.msg["subject"]).to eq("the email subject (updated)")
        expect { MandrillMessageEventRequest.find(mandrill_request_again.id) }.to raise_error(Mongoid::Errors::DocumentNotFound)
      end
    end
  end
end
