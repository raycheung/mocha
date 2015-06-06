class CreateNexmoInboundMessages < ActiveRecord::Migration
  def change
    create_table :nexmo_inbound_messages do |t|
      t.string :type
      t.string :to
      t.string :msisdn
      t.string :message_id
      t.datetime :message_timestamp
      t.text :text
      t.string :keyword
      t.boolean :concat
      t.string :concat_ref
      t.integer :concat_total
      t.integer :concat_part

      t.timestamps null: false
    end
  end
end
