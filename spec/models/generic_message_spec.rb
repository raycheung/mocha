require 'rails_helper'

RSpec.describe GenericMessage, type: :model do
  it { is_expected.to be_timestamped_document.with(:created) }
end
