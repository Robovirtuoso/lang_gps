class EntryForm
  include ActiveModel::Model

  attr_accessor :duration, :duration_type, :language_studied,
    :user, :study_habit, :notes

  validates :duration, presence: true
  validates :duration_type, inclusion: ["Hours", "Minutes"]
  validates :language_studied, presence: true
  validates :study_habit, presence: true, inclusion: Entry::STUDY_HABITS
  validates :user, presence: true

  # should this object validate that the user object
  # passed in responds to `#languages` ?
  # Or should it validate that it is an AR User model?

  def save
    return false unless valid?

    Entry.create(
      duration: converted_duration,
      user_id: user.id,
      study_habit: study_habit,
      language_id: language_studied,
      notes: notes
    )
  end

  def languages
    user.languages
  end

  def language_options
    languages.pluck(:name, :id)
  end

  private

  def converted_duration
    case duration_type
    when "Hours"
      Float(duration).hour.seconds.to_i
    when "Minutes"
      Float(duration).minutes.seconds.to_i
    end
  end

end
