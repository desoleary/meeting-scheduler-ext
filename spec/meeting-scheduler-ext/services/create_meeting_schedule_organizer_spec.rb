# frozen_string_literal: true

module MeetingSchedulerExt
  RSpec.describe CreateMeetingScheduleOrganizer do
    let(:name) { 'Sample Meeting' }
    let(:duration) { 1 }
    let(:type) { Type::ONSITE }
    let(:input) do
      { meetings: [{ name: name, duration: duration, type: type }] }
    end
    let(:errors) { executed_organizer.errors }

    subject(:executed_organizer) { described_class.call(input) }

    it "created schedule successfully" do
      expect(executed_organizer).to be_success
      expect(errors).to be_blank
    end
  end
end

