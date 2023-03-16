# frozen_string_literal: true

require 'bigdecimal'
require 'delegate'

%w[
  version
  constants
  application_organizer
  application_action
  application_context
  application_contract
  application_validator_action
  meeting
  scheduled_meeting
  meeting_collection
  organizer
  contracts/create_meeting_schedule_contract
  services/create_meeting_schedule_validator_action
  services/can_meetings_fit_into_scheduled_action
  services/create_meeting_schedule_action
  services/create_meeting_schedule_organizer
].each do |filename|
  require File.expand_path("../meeting-scheduler-ext/#{filename}", Pathname.new(__FILE__).realpath)
end

module MeetingSchedulerExt; end
