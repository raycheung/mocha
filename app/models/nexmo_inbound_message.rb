class NexmoInboundMessage < ActiveRecord::Base
  def self.inheritance_column
    :nexmo_message_type
  end

  scope :last_14_days, -> { where("updated_at > ?", 14.days.ago) }
end
