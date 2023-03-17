module MeetingSchedulerExt
  class CreateMeetingScheduleContract < ApplicationContract
    DURATION_MAX_PRECISION = 2

    params do
      required(:meetings).value(:array, min_size?: 1).each do
        hash do
          required(:name).filled(:string)
          required(:duration).filled(:float)
          required(:type).filled(:symbol, included_in?: Type::ALL)
        end
      end
    end

    rule(:meetings).each do
      if value[:duration].to_s.split(".")[1].length > DURATION_MAX_PRECISION
        key.failure("number of decimal number places must not exceed #{DURATION_MAX_PRECISION}")
      end
    end
  end
end
