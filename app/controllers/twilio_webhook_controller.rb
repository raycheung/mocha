class TwilioWebhookController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:status_callback, :inbound]

  def status_callback
    callback_wrapper do
      TwilioMessageReceipt.create!(
        message_sid: params["MessageSid"],
        sms_sid: params["SmsSid"],
        account_sid: params["AccountSid"],
        from_number: params["From"],
        to_number: params["To"],
        body: params["Body"],
        num_media: params["NumMedia"],
        message_status: params["MessageStatus"],
        error_code: params["ErrorCode"]
      )
    end
  end

  def inbound
    callback_wrapper do
      TwilioInboundMessage.create!(
        message_sid: params["MessageSid"],
        sms_sid: params["SmsSid"],
        sms_message_sid: params["SmsMessageSid"],
        account_sid: params["AccountSid"],
        from_number: params["From"],
        to_number: params["To"],
        body: params["Body"],
        num_media: params["NumMedia"],
        from_city: params["FromCity"],
        from_state: params["FromState"],
        from_country: params["FromCountry"],
        from_zip: params["FromZip"],
        to_city: params["ToCity"],
        to_state: params["ToState"],
        to_country: params["ToCountry"],
        to_zip: params["ToZip"],
        api_version: params["ApiVersion"]
      )
    end
  end

  private

  def callback_wrapper(&block)
    block.call
  rescue StandardError => e
    Rails.logger.error "Caught exception: #{e.message}"
  ensure
    # NOTE: it must be 200 OK for Twilio to work properly
    render nothing: true, status: :ok
  end
end
