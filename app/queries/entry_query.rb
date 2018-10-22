class EntryQuery
  attr_reader :user_id

  def initialize(user_id)
    @user_id = user_id
  end

  def execute(study_habit)
    connection.execute(%Q(
      select string_agg(languages.name, ',') as languages, 
             sum(duration) as total_duration, min(entries.created_at) as min_created, 
             max(entries.created_at) as max_created
      from entries 
      inner join languages on languages.id = entries.language_id 
      where user_id = #{user_id}
      and study_habit = '#{study_habit}'
    )).to_a.first
  end

  private

  def connection
    @connection ||= ActiveRecord::Base.connection
  end
end
