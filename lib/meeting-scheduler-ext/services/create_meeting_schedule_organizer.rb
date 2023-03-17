module MeetingSchedulerExt
  class CreateMeetingScheduleOrganizer < ApplicationOrganizer
    class << self
      def steps
        [CreateMeetingScheduleValidatorAction, CanMeetingsFitIntoScheduledAction, CreateMeetingScheduleAction]
      end
    end
  end
end
