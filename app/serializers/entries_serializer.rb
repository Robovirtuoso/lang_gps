class EntriesSerializer
  attr_reader :params

  def initialize(params={})
    @params = params
  end

  def to_json(*args)
    JSON.generate(structure)
  end

  private

  def structure
    strct = {
      entries: {}
    }

    entry_enum = Entry.joins(study_habits: :entry_study_habits).where(
      user_id: params[:user].id
    ).find_each

    StudyHabit.joins(entries: [:entry_study_habits, :language]).each do |study|
      key = study.name.downcase
      strct[:entries][key] = {}
      
      entry_enum = study.entries.where(user_id: params[:user].id)

      strct[:entries][key][:time_range] = [entry_enum.first.created_at, entry_enum.to_a.last.created_at].uniq

      time = entry_enum.inject(0) do |total, entry|
        total += entry.duration
      end

      strct[:entries][key][:total_time] = ActiveSupport::Duration.build(time).parts
      strct[:entries][key][:languages] = entry_enum.flat_map { |e| e.language.name }

      strct[:entries][key][:collection] = entry_enum.map do |entry|
        length = ActiveSupport::Duration.build(entry.duration).parts[:hours]
        { length: length, when: entry.created_at }
      end
    end

    strct
  end
end
