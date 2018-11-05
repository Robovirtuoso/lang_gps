class StudyHabitSerializer
  attr_reader :type, :entries, :aggregate
  def initialize(type, entries, aggregate)
    @type = type
    @entries = entries
    @aggregate = aggregate
  end

  def time_range
    aggregate.fetch_values("min_created", "max_created").map { |date|
      DateTime.parse(date).to_formatted_s(:db)
    }
  end

  def total_time
    formatted_duration(aggregate["total_duration"])
  end

  def languages
    aggregate["languages"].split(",").uniq
  end

  def build_collection
    entries.map do |entry|
      { when: entry.created_at, length: formatted_duration(entry.duration)  }
    end
  end

  def to_hash
    {
      type => {
        time_range: time_range,
        total_time: total_time,
        languages: languages,
        collection: build_collection
      }
    }
  end

  private

  # This method convert seconds into hours
  # If a duration is less than an hour (ie. 30 mins, 15 mins)
  # It will be converted into a float to represent its hour value
  #
  #   1800 (sec) => 30 minutes => 0.5 hours
  #   2700 (sec) => 45 minutes => 0.75 hours
  #
  def formatted_duration(time_in_seconds)
    parts = ActiveSupport::Duration.build(time_in_seconds).parts

    minutes = if parts[:minutes] > 0
                (parts[:minutes].to_f / 60.0).round(2)
              else
                0
              end

    parts[:hours] + minutes
  end
end
