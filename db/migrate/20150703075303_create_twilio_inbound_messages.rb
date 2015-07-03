class CreateTwilioInboundMessages < ActiveRecord::Migration
  def change
    create_table :twilio_inbound_messages do |t|
      t.string :message_sid
      t.string :sms_sid
      t.string :sms_message_sid
      t.string :account_sid
      t.string :from_number
      t.string :to_number
      t.text :body
      t.integer :num_media
      t.string :from_city
      t.string :from_state
      t.string :from_country
      t.string :from_zip
      t.string :to_city
      t.string :to_state
      t.string :to_country
      t.string :to_zip
      t.string :api_version

      t.timestamps null: false
    end
  end
end
