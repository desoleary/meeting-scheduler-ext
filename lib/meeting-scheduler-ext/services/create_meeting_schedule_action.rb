module MeetingSchedulerExt
  class CreateMeetingScheduleAction < ApplicationAction
    expects :params

    executed do |context|
      params = context.params
      current_time = params[:current_time]
      onsite_meetings = params[:onsite_meetings]
      offsite_meetings = params[:offsite_meetings]
      schedule = []

      # need 30 mins to travel to offsite from onsite
      encountered_offsite_meeting = false

      (onsite_meetings + offsite_meetings).map do |meeting|
        if meeting.type == Type::OFFSITE && !encountered_offsite_meeting
          encountered_offsite_meeting = true
          current_time += TRAVEL_TIME
        end

        scheduled_meeting = ScheduledMeeting.new(meeting, current_time)
        schedule << scheduled_meeting
        current_time = scheduled_meeting.end_at
      end

      context.add_params(schedule: schedule)

      schedule_meetings_txt = ['Yes, can fit. One possible solution would be:']
      schedule_meetings_txt.concat(schedule.map(&:to_s))
      context.add_params(schedule_meetings_txt: schedule_meetings_txt.join("\n"))
    end
  end
end
