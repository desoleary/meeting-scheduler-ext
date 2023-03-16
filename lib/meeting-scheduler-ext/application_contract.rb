module MeetingSchedulerExt
  class ApplicationContract < LightServiceExt::ApplicationContract
    register_macro(:precision) do |macro:|
      num = macro.args[0] || 2
      if value && value.to_s.split('.').last.size > num
        key.failure("number of decimal number places must not exceed #{num}")
      end
    end
  end
end
