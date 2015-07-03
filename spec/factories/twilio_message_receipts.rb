FactoryGirl.define do
  factory :twilio_message_receipt do
    message_sid "SM1d3acc1bd23b4c1c804acabaf9d21c84"
    sms_sid "SM1d3acc1bd23b4c1c804acabaf9d21c84"
    account_sid "ACdd97bf82b69136067317b819977d7941"
    from_number "+85264522710"
    to_number "+85293806050"
    body "你好嗎!"
    message_status "sent"
    error_code nil
  end
end
