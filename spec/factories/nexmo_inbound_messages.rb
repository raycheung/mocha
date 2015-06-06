FactoryGirl.define do
  factory :nexmo_inbound_message do
    type "unicode"
    to "85264506025"
    msisdn "85293806050"
    message_id "0200000065AB6212"
    message_timestamp "2015-06-06 06:38:30"
    text "隨便你"
    keyword "???"

    trait :concat do
      concat true
      concat_ref "3"
      concat_total 2
      concat_part 2
    end
  end
end
