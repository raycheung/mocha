class SearchNexmoDeliveredMessage < Struct.new(:nexmo_delivery_receipt_id)
  attr_reader :nexmo_delivery_receipt

  def perform
    client = Nexmo::Client.new(key: Rails.application.secrets.nexmo_api_key, secret: Rails.application.secrets.nexmo_api_secret)
    @nexmo_delivery_receipt = NexmoDeliveryReceipt.find(nexmo_delivery_receipt_id)
    message = client.get_message(@nexmo_delivery_receipt.message_id)
    @nexmo_delivery_receipt.body = message["body"]
    if message["type"] == "MT" # an outbound message
      @nexmo_delivery_receipt.date_received = message["date-received"]
      @nexmo_delivery_receipt.final_status = message["final-status"]
      @nexmo_delivery_receipt.date_closed = message["date-closed"]
      @nexmo_delivery_receipt.latency = message["latency"]
    end
    @nexmo_delivery_receipt.save!
  end

  def queue_name
    'nexmo_message'
  end

  def success(_job)
    Rails.logger.debug "messageId: #{@nexmo_delivery_receipt.message_id} body: [#{@nexmo_delivery_receipt.body}]"
  end

  def error
    Rails.logger.error "failed to search for messageId: #{@nexmo_delivery_receipt.message_id}"
  end
end
