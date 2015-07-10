class ProcessGenericMessagesJob < ActiveJob::Base
  queue_as :default

  def perform(generic_messages_request_id)
    generic_messages_request = GenericMessagesRequest.find(generic_messages_request_id)
    messages = JSON.parse(generic_messages_request.messages)
    messages.each do |message|
      sender = message["from"]
      if !sender && message["direction"] == "inbound"
        sender = message["mobile"]
      else
        sender ||= "system"
      end

      recipient = message["to"]
      if !recipient && message["direction"] == "outbound"
        recipient = message["mobile"]
      else
        recipient ||= "system"
      end

      GenericMessage.create(
        sender: sender,
        recipient: recipient,
        body: message["body"],
        received_at: message["received_at"]
      )
    end
  end
end
