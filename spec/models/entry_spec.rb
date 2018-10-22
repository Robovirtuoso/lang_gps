require 'rails_helper'

RSpec.describe Entry do
  it { is_expected.to validate_presence_of(:study_habit) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:language_id) }

  it { 
    is_expected.to validate_inclusion_of(:study_habit).in_array(
      %w(listening reading speaking writing)
    ) 
  }
end
