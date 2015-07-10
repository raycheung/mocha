require 'rails_helper'

RSpec.describe ProcessGenericMessagesJob, type: :job do
  let(:messages) do
    "[{\"body\":\"在嗎\",\"sender\":\"85293806050\",\"recipient\":\"system\",\"received_at\":\"2015-07-08 10:42:34 +0800\"},{\"body\":\"可以比個號碼我確認嗎~?\",\"sender\":\"system\",\"recipient\":\"85293806050\",\"received_at\":\"2015-07-08 10:56:38 +0800\"},{\"body\":\"反光..睇唔清\",\"sender\":\"system\",\"recipient\":\"85293806050\",\"received_at\":\"2015-07-08 10:56:45 +0800\"},{\"body\":\"你好，上午查詢，但還未收到\",\"sender\":\"85233667711\",\"recipient\":\"system\",\"received_at\":\"2015-07-08 16:03:54 +0800\"},{\"body\":\"呢D服務態度，冇人應😠\",\"sender\":\"system\",\"recipient\":\"85293806050\",\"received_at\":\"2015-07-08 16:03:54 +0800\"}]"
  end
  let(:messages_request) { GenericMessagesRequest.create(messages: messages) }

  describe '#perform' do
    it 'process the raw request and save into messages' do
      # somehow ActiveJob serialization doesn't work well with Mongoid
      # so we literally pass the id as a string
      expect { ProcessGenericMessagesJob.perform_later(messages_request.id.to_s) }.to change { GenericMessage.count }.by(5)

      message = GenericMessage.last
      expect(message.body).to eq "呢D服務態度，冇人應😠"
    end
  end
end
