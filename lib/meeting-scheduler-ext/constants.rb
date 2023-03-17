module MeetingSchedulerExt
  module Type
    ONSITE = :onsite
    OFFSITE = :offsite
    ALL = [ONSITE, OFFSITE].freeze
  end

  START_WORK = 9.0
  END_WORK = 17.0
  WORK_DURATION = END_WORK - START_WORK
  TRAVEL_TIME = 0.5
end
