FactoryGirl.define do
  factory :mandrill_message_event_request do
    mandrill_events "[{\"event\":\"send\",\"msg\":{\"ts\":1436166540,\"subject\":\"the email subject\",\"email\":\"ray.swc@gmail.com\",\"tags\":[],\"opens\":[],\"clicks\":[],\"state\":\"sent\",\"smtp_events\":[],\"subaccount\":null,\"resends\":[],\"reject\":null,\"sender\":\"donotreply@mocha.mandrillapp.com\",\"template\":\"template-tc\"},\"ts\":1436166540}]"
  end
end
