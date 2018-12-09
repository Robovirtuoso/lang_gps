class DashboardEntryPresenter
  include ActiveModel::Conversion
  extend Forwardable

  attr_reader :entry, :id

  def_delegators :@entry, :study_habit, :id, :persisted?

  def initialize(entry)
    @entry = entry
  end
  
  def language_name
    entry.language.name
  end

  def study_time
    TimeConverter.stringify(entry.duration)
  end

end
