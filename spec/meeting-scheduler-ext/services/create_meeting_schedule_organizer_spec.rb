# frozen_string_literal: true

module MeetingSchedulerExt
  RSpec.describe CreateMeetingScheduleOrganizer do
    let(:name) { 'Sample Meeting' }
    let(:duration) { 1 }
    let(:type) { Type::ONSITE }
    let(:meetings) do
      [
        { name: 'Meeting 1', duration: 3, type: :onsite },
        { name: 'Meeting 2', duration: 2, type: :offsite },
        { name: 'Meeting 3', duration: 1, type: :offsite },
        { name: 'Meeting 4', duration: 0.5, type: :onsite }
      ]
    end
    let(:input) { { meetings: meetings } }
    let(:errors) { executed_organizer.errors }

    subject(:executed_organizer) { described_class.call(input) }

    it "created schedule successfully" do
      expect(executed_organizer).to be_success
      expect(errors).to be_blank

      expect(executed_organizer.params[:schedule_meetings_txt]).to eql(<<~TEXT.strip
        Yes, can fit. One possible solution would be:
        9:00 - 12:00 - Meeting 1
        12:00 - 12:30 - Meeting 4
        1:00 - 3:00 - Meeting 2
        3:00 - 4:00 - Meeting 3
      TEXT
                                                                      )
    end

    context 'with too many offsite meetings' do
      let(:meetings) do
        [
          { name: 'Meeting 1', duration: 4, type: :offsite },
          { name: 'Meeting 2', duration: 4, type: :offsite }
        ]
      end

      it 'fails the context and returns appropriate error message' do
        expect(executed_organizer.failure?).to be_truthy

        params = executed_organizer.params
        expect(params.keys).to include(:schedule_meetings_txt)
        expect(errors).to eql(meetings: "No, can’t fit.")
        expect(params[:schedule_meetings_txt]).to eql("No, can’t fit.")
      end
    end
  end
end

