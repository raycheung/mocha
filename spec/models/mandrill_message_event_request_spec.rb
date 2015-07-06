require 'rails_helper'

RSpec.describe MandrillMessageEventRequest, type: :model do
  it { is_expected.to be_dynamic_document }
  it { is_expected.to be_timestamped_document.with(:created) }
end
