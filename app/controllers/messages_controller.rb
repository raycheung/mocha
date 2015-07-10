class MessagesController < ApplicationController
  before_action :authenticate
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    params.require(:mobile)

    nexmo_outbound = NexmoDeliveryReceipt.last_14_days.delivered.where(msisdn: params[:mobile])
    nexmo_inbound = NexmoInboundMessage.last_14_days.where(msisdn: params[:mobile])

    @nexmo_messages = (nexmo_outbound.map { |dr| { message_timestamp: dr.message_timestamp, type: "outbound", body: dr.body, ref: dr.client_ref } } +
                       nexmo_inbound.map { |im| { message_timestamp: im.message_timestamp, type: "inbound", body: im.text } }).
                      sort_by! { |m| [m["message_timestamp"], m["type"]] }
  rescue ActionController::ParameterMissing
    render status: :bad_request
  end

  def create
    messages = params.require(:messages)
    messages.each do |message|
      GenericMessage.new(
        sender: message["sender"],
        recipient: message["recipient"],
        body: message["body"],
        received_at: message["received_at"]
      ).upsert
    end

    render nothing: true, status: :ok
  end

  private

    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        token == Rails.application.secrets.api_token
      end
    end
end
