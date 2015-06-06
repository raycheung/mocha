class NexmoWebhookController< ApplicationController
  def dlr_callback
    callback_wrapper do
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

      Rails.logger.info "Recorded for #{params['messageId']}, status: #{params['status']}"
    end
  end

  def inbound
    callback_wrapper do
      NexmoInboundMessage.create!(
        type: params['type'],
        to: params['to'],
        msisdn: params['msisdn'],
        message_id: params['messageId'],
        message_timestamp: params['message-timestamp'],
        text: params['text'],
        keyword: params['keyword'],
        concat: params['concat'],
        concat_ref: params['concat-ref'],
        concat_total: params['concat-total'],
        concat_part: params['concat-part']
      )

      Rails.logger.info "Recorded for #{params['messageId']}, from: #{params['msisdn']}"
    end
  end

  private

  def callback_wrapper(&block)
    params.require(:messageId)

    block.call
  rescue StandardError => e
    Rails.logger.error "Caught exception: #{e.message}"
  ensure
    # NOTE: it must be 200 OK for Nexmo to work properly
    render nothing: true, status: :ok
  end
end
