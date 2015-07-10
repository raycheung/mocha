class GenericMessage
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :sender, type: String
  field :recipient, type: String
  field :body, type: String
  field :received_at, type: Time
end
