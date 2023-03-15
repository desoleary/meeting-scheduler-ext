# frozen_string_literal: true

require 'bigdecimal'
require 'delegate'

%w[
  version
  meeting
  scheduled_meeting
  meeting_collection
  organizer
].each do |filename|
  require File.expand_path("../meeting-scheduler-ext/#{filename}", Pathname.new(__FILE__).realpath)
end


module MeetingSchedulerExt ; end
