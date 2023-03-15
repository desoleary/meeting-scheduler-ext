module MeetingScheduler
  class Organizer
    START_WORK = 9.0
    END_WORK = 17.0
    WORK_DURATION = END_WORK - START_WORK
    TRAVEL_TIME = 0.5

    # @param [Array<Hash>] meetings an array of hashes each having keys :name, :duration, and :type
    def initialize(meetings)
      @meetings = meetings
      @current_time = START_WORK

      onsite_meetings, offsite_meetings = meetings.partition { |m| m[:type] == :onsite }
      # sort meetings so that longest durations start first
      @onsite_meetings = MeetingCollection.new(onsite_meetings)
      @offsite_meetings = MeetingCollection.new(offsite_meetings)
    end

    # @return [TrueClass, FalseClass] true if meetings can be scheduled within work day otherwise false
    def can_schedule_meetings?
      total_duration = @onsite_meetings.total_duration
      total_duration += @offsite_meetings.total_duration
      total_duration += TRAVEL_TIME if @offsite_meetings.present?

      WORK_DURATION >= total_duration
    end

    def schedule_meetings
      return 'No, can’t fit.' unless can_schedule_meetings?

      (['Yes, can fit. One possible solution would be:'] + organize_schedule.map(&:to_s)).join("\n")
    end

    def organize_schedule
      current_time = START_WORK
      schedule = []

      @onsite_meetings.map do |meeting|
        scheduled_meeting = ScheduledMeeting.new(meeting, current_time)
        schedule << scheduled_meeting
        current_time = scheduled_meeting.end_at
      end

      @offsite_meetings.each do |meeting|
        current_time += TRAVEL_TIME if @onsite_meetings.present? # need 30 mins to travel to offsite from onsite
        scheduled_meeting = ScheduledMeeting.new(meeting, current_time)
        schedule << scheduled_meeting
        current_time = scheduled_meeting.end_at
      end

      schedule
    end
  end
end
