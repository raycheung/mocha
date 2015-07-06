require 'rails_helper'

RSpec.describe ProcessMandrillMessageEvents, type: :job do
  let(:mandrill_events) do
    "[{\"event\":\"send\",\"msg\":{\"ts\":1436166540,\"subject\":\"the email subject\",\"email\":\"ray.swc@gmail.com\",\"tags\":[],\"opens\":[],\"clicks\":[],\"state\":\"sent\",\"smtp_events\":[],\"subaccount\":null,\"resends\":[],\"reject\":null,\"sender\":\"donotreply@mocha.mandrillapp.com\",\"template\":\"template-tc\"},\"ts\":1436166540}]"
  end
  let(:mandrill_request) { MandrillMessageEventRequest.create(mandrill_events: mandrill_events) }

  describe '#perform' do
    it 'digests the raw mandrill request into multiple events' do
      expect { ProcessMandrillMessageEvents.new(mandrill_request.id).perform }.to change { MandrillMessageEvent.count }.by(1)
    end
  end
end
