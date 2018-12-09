class EditEntryForm
  include ActiveModel::Model

  def initialize(attributes={})
    if attributes[:entry].blank?
      raise ArgumentError.new("Missing argument `@entry`")
    end

    super
  end

  attr_accessor :entry, :user, 
    :language_studied, :study_habit, :duration, :duration_type, :notes

  validates :language_studied, presence: :true
  validates :duration_type, inclusion: ["Hours", "Minutes"]
  validates :study_habit, inclusion: Entry::STUDY_HABITS

  def save
    return false unless valid?

    @entry.update_attributes(
      language_id: language_studied,
      study_habit: study_habit,
      duration: converted_duration(duration, duration_type)
    )
  end

  def study_habit
    @study_habit || @entry.study_habit
  end

  def notes
    @notes || @entry.notes
  end

  def language_options
    user.languages.pluck(:name, :id)
  end

  def language_default
    [@entry.language.name, @entry.language.id]
  end

  def duration_type
    @duration_type || begin
      TimeConverter.exceeds_hour?(entry.duration,
        true: -> {
          "Hours"
        },
        false: -> {
          "Minutes"
        }
      )
    end
  end

  def duration
    @duration || TimeConverter.numerify(entry.duration)
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

  def study_time
    TimeConverter.stringify(entry.duration)
  end

end
