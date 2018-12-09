class EntryForm
  include ActiveModel::Model

  attr_accessor :language_studied, :user, :study_habit, 
                :notes, :entries

  # This form accepts attributes to create multiple entry objects.
  # This validation loops over each entry verifying that they are all
  # valid.

  validates_each :entries do |record, attr, value|
    Array(value).each { |entry|
      record.errors.add(attr, "Invalid attributes for entry") if EntryValidator.new(entry).invalid?
    }
  end

  validates :entries, presence: true, length: { maximum: 4 }

  validates :language_studied, presence: true
  validates :user, presence: true

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
