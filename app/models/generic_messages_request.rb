class GenericMessagesRequest
  include GlobalID::Identification
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :messages, type: String
end
