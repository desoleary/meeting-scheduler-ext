module MeetingSchedulerExt
  class CanMeetingsFitIntoScheduledAction < ApplicationAction
    expects :params

    executed do |context|
      context.add_params(current_time: START_WORK)

      onsite_meetings, offsite_meetings = context.params[:meetings].partition { |m| m[:type] == Type::ONSITE }

      context.add_params(onsite_meetings: MeetingCollection.new(onsite_meetings))
      context.add_params(offsite_meetings: MeetingCollection.new(offsite_meetings))

      # NOTE: `add_errors!` fails the organizer's context.
      #        Ensure subsequent actions are prevented from being inadvertently called
      context.add_errors!(meetings: 'No, can’t fit.') unless can_schedule_meetings?(context)
    end

    class << self
      private

      def can_schedule_meetings?(ctx)
        total_duration = ctx.params[:onsite_meetings].total_duration

        offsite_meetings = ctx.params[:offsite_meetings]
        total_duration += offsite_meetings.total_duration
        total_duration += TRAVEL_TIME if offsite_meetings.present?

        WORK_DURATION >= total_duration
      end
    end
  end
end
