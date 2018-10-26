class EntryValidator
  include ActiveModel::Model
  attr_accessor :study_habit, :duration, :duration_type
  validates :duration, presence: true
  validates :duration_type, inclusion: ["Hours", "Minutes"]
  validates :study_habit, presence: true, inclusion: Entry::STUDY_HABITS

  validate :duration_is_floatable

  def duration_is_floatable
    begin
      Float(duration)
    rescue ArgumentError, TypeError
      errors.add(:duration, "Cannot be converted into a Float")
    end
  end
end
