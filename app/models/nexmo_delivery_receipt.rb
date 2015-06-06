class NexmoDeliveryReceipt < ActiveRecord::Base
  scope :last_14_days, -> { where("updated_at > ?", 14.days.ago) }
  scope :delivered, -> { where(status: "delivered") }
end
