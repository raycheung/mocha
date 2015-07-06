Mocha
===

### Twilio
When sending a SMS via the REST API (or the ruby client which calls the REST API), specify the `StatusCallback`, as described in the [API](https://www.twilio.com/docs/api/rest/sending-messages).
For inbound messages, please set the `Request URL` under the `SMS & MMS` section of the Twilio **phone number**.

### Nexmo
Make sure the endpoint is set to [Nexmo's console](https://dashboard.nexmo.com/private/settings) after deployment.

### Mandrill
Register the webhook under [Webhooks](https://mandrillapp.com/settings/webhooks) in the Settings.

