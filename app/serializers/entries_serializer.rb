class EntriesSerializer
  attr_reader :params, :user_id, :serializers

  def initialize(params={})
    @user_id = params.fetch(:user_id)
    @serializers ||= []
  end

  def to_json(*args)
    JSON.generate(structure)
  end

  private

  def entries
    @entries ||= Entry.where(user_id: user_id)
  end

  def query
    @query ||= EntryQuery.new(user_id)
  end

  def build_total_time
    formatted_duration(entries.pluck(:duration).inject(:+))
  end

  def formatted_duration(time_in_seconds)
    parts = ActiveSupport::Duration.build(time_in_seconds).parts

    minutes = if parts[:minutes] > 0
                (parts[:minutes].to_f / 60.0).round(2)
              else
                0
              end

    parts[:hours] + minutes
  end

  def base_struct
    @base_struct ||= { 
      entries: {
        total_time: build_total_time
      } 
    }.with_indifferent_access
  end

  def structure
    entries.by_study.each_pair do |study, entry_array|
      serializers << StudyHabitSerializer.new(study, entry_array, query.execute(study)) 
    end

    serializers << LanguageSerializer.new(entries.by_language)

    serializers.each do |serializer|
      base_struct[:entries].merge!(serializer)
    end

    base_struct
  end
end
