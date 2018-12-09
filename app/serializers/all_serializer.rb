class AllSerializer
  attr_reader :entries

  def initialize(entries)
    @entries = entries
  end

  def to_hash
    { all: build_collection }
  end

  def build_collection
    entries.map do |entry|
      { when: entry.created_at, length: formatted_duration(entry.duration)  }
    end
  end
  private

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
