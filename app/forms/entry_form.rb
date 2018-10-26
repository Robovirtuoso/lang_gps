class EntryForm
  include ActiveModel::Model

  attr_accessor :language_studied, :user, :study_habit, 
                :notes, :entries

  ## Refactor
  # Is there a better way to express this validation behavior?

  validates_each :entries do |record, attr, value|
    Array(value).each { |entry|
      record.errors.add(attr, "Invalid attributes for entry") if EntryValidator.new(entry).invalid?
    }
  end

  ## /end_refactor

  validates :entries, presence: true, length: { maximum: 4 }

  validates :language_studied, presence: true
  validates :user, presence: true

  # should this object validate that the user object
  # passed in responds to `#languages` ?
  # Or should it validate that it is an AR User model?

  def save
    return false unless valid?

    Entry.create(entry_attributes)
  end

  def entry_attributes
    entries.map do |entry|
      {
        duration: converted_duration(entry[:duration], entry[:duration_type]),
        user_id: user.id,
        study_habit: entry[:study_habit],
        language_id: language_studied,
        notes: notes
      }
    end
  end

  def languages
    user.languages
  end

  def language_options
    languages.pluck(:name, :id)
  end

  def proxy_entry
    ProxyEntry.new
  end

  private

  def converted_duration(duration, duration_type)
    case duration_type
    when "Hours"
      Float(duration).hour.seconds.to_i
    when "Minutes"
      Float(duration).minutes.seconds.to_i
    end
  end

end
