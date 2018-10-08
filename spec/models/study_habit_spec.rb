require 'rails_helper'

RSpec.describe StudyHabit do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_inclusion_of(:name).in_array(%w(Listening Speaking Writing Reading)) }
end
