json.array! @nexmo_messages do |nexmo_message|
  json.(nexmo_message, :message_timestamp, :type, :body)
  json.ref nexmo_message[:ref] if nexmo_message[:ref]
end
