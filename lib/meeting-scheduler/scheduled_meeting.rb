module MeetingScheduler
  class ScheduledMeeting
    attr_reader :meeting, :start_at, :end_at

    def initialize(meeting, current_time)
      @meeting = meeting
      @start_at = current_time
      @end_at = current_time + meeting.duration
      @start_of_day_time = Date.today.to_time.freeze
    end

    def to_s
      "#{formatted_start_time} - #{formatted_end_time} - #{meeting.name}"
    end

    private

    # @return [String] formatted time meeting starts at
    def formatted_start_time
      format_time(@start_at)
    end

    # @return [String] formatted time meeting ends at
    def formatted_end_time
      format_time(@end_at)
    end

    def format_time(hours)
      (@start_of_day_time + (hours * 60 * 60)).strftime("%l:%M").strip
    end
  end
end
