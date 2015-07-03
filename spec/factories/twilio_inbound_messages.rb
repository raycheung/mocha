FactoryGirl.define do
  factory :twilio_inbound_message do
    message_sid "SM1d3acc1bd23b4c1c804acabaf9d21c84"
    sms_sid "SM1d3acc1bd23b4c1c804acabaf9d21c84"
    sms_message_sid"SMd7ca0b691e90c9ac3d125c79ec710ac4"
    account_sid "ACdd97bf82b69136067317b819977d7941"
    from_number "+85264522710"
    to_number "+85264522710"
    body "你好嗎!"
  end
end
