# frozen_string_literal: true

module MeetingSchedulerExt
  RSpec.describe CreateMeetingScheduleAction do
    let(:input) { { meetings: meetings } }
    let(:ctx) do
      LightService::Testing::ContextFactory
        .make_from(CreateMeetingScheduleOrganizer)
        .for(described_class)
        .with(input)
    end
    let(:errors) { executed_action.errors }

    subject(:executed_action) { described_class.execute(ctx) }

    context 'with simple meetings' do
      let(:meetings) do
        [
          { name: 'Meeting 1', duration: 3, type: :onsite },
          { name: 'Meeting 2', duration: 2, type: :offsite },
          { name: 'Meeting 3', duration: 1, type: :offsite },
          { name: 'Meeting 4', duration: 0.5, type: :onsite }
        ]
      end

      it 'returns meetings with least amount of trips' do
        expect(executed_action.success?).to be_truthy

        params = executed_action.params
        expect(params.keys).to eql(%i[
                                     meetings
                                     current_time
                                     onsite_meetings
                                     offsite_meetings
                                     schedule
                                     schedule_meetings_txt
                                   ])

        schedule = params[:schedule]
        expect(schedule.map(&:name)).to eql(["Meeting 1", "Meeting 4", "Meeting 2", "Meeting 3"])
        expect(schedule.map(&:type)).to eql(%i[onsite onsite offsite offsite])
        expect(schedule.map(&:duration)).to eql([3.0, 0.5, 2.0, 1.0])

        expect(params[:schedule_meetings_txt]).to eql(<<~TEXT.strip
          Yes, can fit. One possible solution would be:
          9:00 - 12:00 - Meeting 1
          12:00 - 12:30 - Meeting 4
          1:00 - 3:00 - Meeting 2
          3:00 - 4:00 - Meeting 3
        TEXT
                                                     )
      end
    end
  end
end
