class EntryForm
  include ActiveModel::Model

  attr_accessor :duration, :duration_type, :language_studied,
    :user, :study_habits, :notes

  validates :duration, presence: true
  validates :duration_type, inclusion: ["Hours", "Minutes"]
  validates :language_studied, presence: true
  validates :study_habits, presence: true
  validates :user, presence: true

  # should this object validate that the user object
  # passed in responds to `#languages` ?
  # Or should it validate that it is an AR User model?

  def save
    return false unless valid?

    options = {
      duration: converted_duration,
      user_id: user.id,
      language_id: language_studied,
      notes: notes
    }

    Entry.create(options).tap do |entry|
      entry.study_habits << StudyHabit.where(id: study_habits)
    end
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
      Integer(duration).hour.seconds.to_i
    when "Minutes"
      Integer(duration).minutes.seconds.to_i
    end
  end

end
