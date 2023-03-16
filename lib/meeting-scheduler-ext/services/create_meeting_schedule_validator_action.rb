module MeetingSchedulerExt
  class CreateMeetingScheduleValidatorAction < LightServiceExt::ApplicationValidatorAction
    self.contract_class = CreateMeetingScheduleContract
  end
end
