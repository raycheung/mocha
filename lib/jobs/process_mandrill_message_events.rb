class ProcessMandrillMessageEvents < Struct.new(:mandrill_message_event_request_id)
  def perform
    mandrill_request = MandrillMessageEventRequest.find(mandrill_message_event_request_id)
    events = JSON.parse(mandrill_request.mandrill_events)
    events.each { |event| MandrillMessageEvent.new(event).upsert }
  end
end
