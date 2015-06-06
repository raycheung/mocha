class NexmoWebhookController< ApplicationController
  def dlr_callback
    dr = NexmoDeliveryReceipt.create!(
      to: params['to'],
      network_code: params['network-code'],
      message_id: params['messageId'],
      msisdn: params['msisdn'],
      status: params['status'],
      err_code: params['err-code'],
      price: params['price'],
      scts: params['scts'],
      message_timestamp: params['message-timestamp'],
      client_ref: params['client-ref']
    )

    Delayed::Job.enqueue(SearchNexmoDeliveredMessage.new(dr.id))
  rescue StandardError => e
    Rails.logger.error "Caught exception: #{e.message}"
  else
    Rails.logger.info "Recorded for #{params['messageId']}, status: #{params['status']}"
  ensure
    # NOTE: it must be 200 OK for Nexmo to work properly
    render nothing: true, status: :ok
  end
end
