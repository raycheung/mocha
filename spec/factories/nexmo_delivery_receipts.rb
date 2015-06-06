FactoryGirl.define do
  factory :nexmo_delivery_receipt do
    to "WeLend.hk"
    network_code "45406"
    message_id "0200000065A28CFC"
    msisdn "85293806050"
    status "delivered"
    err_code 0
    price "0.02080000"
    scts "1506061003"
    message_timestamp DateTime.new(2015, 6, 6, 10, 3, 25)
    client_ref "ray.cheung@welab.co"

    trait :full do
      body "WeLend.hk: 歡迎登記成為 WeLend.hk 會員！請輸入048889以確認你的電話號碼。查詢35906396"
      date_received DateTime.new(2015, 6, 3, 3, 19, 10)
      date_closed DateTime.new(2015, 6, 6, 3, 19, 14)
      latency 259203625
      final_status "EXPIRED"
    end
  end
end
