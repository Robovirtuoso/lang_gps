module TimeConverter

  ##
  # This method executes blocks of code based on whether the
  # provided `time_in_seconds` exceeds an hour. Functioning identical
  # to a policy object, you should pass in a `true` and/or `false` callback.
  # This encapsulates the logic for functionality tied to whether a certain duration
  # exceeds an hour or not.
  #
  def self.exceeds_hour?(time_in_seconds, callbacks={})
    truthy_callback = callbacks.fetch(:true, -> {})
    falsey_callback = callbacks.fetch(:false, -> {})

    if time_in_seconds >= 3600
      truthy_callback.call
    else
      falsey_callback.call
    end
  end

  ##
  # This method convert seconds into hours
  # If a duration is less than an hour (ie. 30 mins, 15 mins)
  # It will be converted into a float to represent its hour value
  #
  #   1800 (sec) => 30 minutes => 0.5 hours
  #   2700 (sec) => 45 minutes => 0.75 hours
  #
  def self.to_hours(time_in_seconds)
    parts = time_segments(time_in_seconds)

    minutes = if parts[:minutes] > 0
                (parts[:minutes].to_f / 60.0).round(2)
              else
                0
              end

    parts[:hours] + minutes
  end

  ##
  # This method convert seconds into its appropriate time value
  # If a duration is less than an hour (ie. 30 mins, 15 mins)
  # It will be converted into its minute value.
  #
  #   1800 (sec) => 30 minutes => 30 (minutes)
  #   2700 (sec) => 45 minutes => 45 (minutes)
  #   3600 (sec) => 1 hour => 1 (hour)
  #   5400 (sec) => 1 and a half hour => 1.5 (hour)
  #
  def self.numerify(time_in_seconds)
    parts = time_segments(time_in_seconds)

    exceeds_hour?(time_in_seconds, 
      true: -> {
        to_hours(time_in_seconds)
      },
      false: -> {
        parts[:minutes]
      }
    )
  end

  ##
  # This method converts seconds into its appropriate time value
  # in the form of a string accompanied by an `Hour/Minute` handle.
  #
  #   1800 (sec) => "30 Minutes"
  #   3600 (sec) => "1 Hour"
  #   7200 (sec) => "2 Hours"

  def self.stringify(time_in_seconds)
    parts = time_segments(time_in_seconds)

    exceeds_hour?(time_in_seconds, 
      true: -> {
        hours = to_hours(time_in_seconds)
        "#{hours} Hour".pluralize(hours)
      },
      false: -> {
        "#{parts[:minutes]} Minute".pluralize(parts[:minutes])
      }
    )
  end

  private

  def self.time_segments(time)
    ActiveSupport::Duration.build(time).parts
  end
end
