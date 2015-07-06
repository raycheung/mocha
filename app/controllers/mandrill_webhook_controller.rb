class MandrillWebhookController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:message_event]

  def health_check
    render nothing: true, status: :ok
  end

  def message_event
    raise if params[:mandrill_events].empty? || params[:mandrill_events] == "[]"
    event_request = MandrillMessageEventRequest.create!(mandrill_events: params[:mandrill_events])
    Delayed::Job.enqueue(ProcessMandrillMessageEvents.new(event_request.id))
    render nothing: true, status: :ok
  rescue StandardError
    render nothing: true, status: :bad_request
  end
end
