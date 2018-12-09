class LanguageSerializer
  attr_reader :entries

  def initialize(entries)
    @entries = entries
  end

  def to_hash
    {
      languages: language_habits
    }
  end

  def total_time(entries)
    formatted_duration(entries.pluck(:duration).inject(:+))
  end

  def build_collection(entries)
    entries.map do |entry|
      { 
        when: entry.created_at,
        length: formatted_duration(entry.duration),
        study_habit: entry.study_habit
      }
    end
  end

  def build_study_habits(entries)
    habits = Hash.new { |hash, key| hash[key] = 0 }

    entries.each do |entry|
      habits[entry.study_habit] += formatted_duration(entry.duration)
    end

    habits
  end

  def language_habits
    base_hash = {}

    entries.each_pair do |lang, array|
      base_hash[lang] = {
        # since the entries have already been grouped by language id
        # all entries in the array will belong to the same language
        id: array.first.language_id,
        total_time: total_time(array),
        study_habits: build_study_habits(array),
        collection: build_collection(array)
      }
    end

    base_hash
  end

  private

  def formatted_duration(time_in_seconds)
    TimeConverter.to_hours(time_in_seconds)
  end
end
