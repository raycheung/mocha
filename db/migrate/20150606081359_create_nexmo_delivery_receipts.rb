class CreateNexmoDeliveryReceipts < ActiveRecord::Migration
  def change
    create_table :nexmo_delivery_receipts do |t|
      t.string :to
      t.string :network_code
      t.string :message_id
      t.string :msisdn
      t.string :status
      t.integer :err_code
      t.decimal :price
      t.string :scts
      t.datetime :message_timestamp
      t.string :client_ref
      t.string :body
      t.datetime :date_received
      t.datetime :date_closed
      t.integer :latency
      t.string :final_status
      t.string :error_code_label

      t.timestamps null: false
    end
  end
end
