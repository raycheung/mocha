class CreateTwilioMessageReceipts < ActiveRecord::Migration
  def change
    create_table :twilio_message_receipts do |t|
      t.string :message_sid
      t.string :sms_sid
      t.string :account_sid
      t.string :from_number
      t.string :to_number
      t.text :body
      t.integer :num_media
      t.string :message_status
      t.string :error_code

      t.timestamps null: false
    end
  end
end
