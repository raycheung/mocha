class NexmoInboundMessage < ActiveRecord::Base
  def self.inheritance_column
    :nexmo_message_type
  end
end
