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
    parts = ActiveSupport::Duration.build(entry.duration).parts

    if entry.duration >= 3600
      "#{parts[:hours]} Hour".pluralize(parts[:hours])
    else
      "#{parts[:minutes]} Minute".pluralize(parts[:minutes])
    end
  end

end
