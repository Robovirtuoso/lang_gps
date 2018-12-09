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

  def formatted_duration(time_in_seconds)
    TimeConverter.to_hours(time_in_seconds)
  end
end
