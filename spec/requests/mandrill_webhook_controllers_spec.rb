require 'rails_helper'

RSpec.describe MandrillWebhookController, type: :request do

  # Mandrill requires a health check when registering the webhook
  # It's done by either HEAD or POST (w/ a test payload)
  # It's actually allowing GET here, but Mandrill would only do HEAD anyway
  describe "HEAD /mandrill/message_event" do
    it "is success" do
      head '/mandrill/message_event'
      expect(response).to have_http_status(:success)
    end
  end

end
