class DashboardEntryPresenter
  attr_reader :entry
  def initialize(entry)
    @entry = entry
  end
  
  def language_name
    entry.language.name
  end

  def study_habit
    entry.study_habit
  end

  def study_time
    parts = ActiveSupport::Duration.build(entry.duration).parts

    if entry.duration >= 3600
      "#{parts[:hours]} Hour(s)"
    else
      "#{parts[:minutes]} Minute(s)"
    end
  end
end
