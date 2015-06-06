json.array! @nexmo_messages do |nexmo_message|
  json.(nexmo_message, :message_timestamp, :type, :body)
end
