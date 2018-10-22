class EntriesSerializer
  attr_reader :params, :user_id

  def initialize(params={})
    @user_id = params.fetch(:user_id)
  end

  def to_json(*args)
    JSON.generate(structure)
  end

  private

  def entries
    @entries ||= Entry.where(user_id: user_id).group_by(&:study_habit)
  end

  def query
    @query ||= EntryQuery.new(user_id)
  end

  def base_struct
    @base_struct ||= { entries: {} }.with_indifferent_access
  end

  def structure
    entries.each_pair do |study, entry_array|
      serializer = StudyHabitSerializer.new(study, entry_array, query.execute(study)) 
      base_struct[:entries].merge!(serializer)
    end

    base_struct
  end
end
