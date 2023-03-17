# frozen_string_literal: true

module MeetingSchedulerExt
  RSpec.describe CanMeetingsFitIntoScheduledAction do
    let(:input) { { meetings: meetings } }
    let(:ctx) do
      LightService::Testing::ContextFactory
        .make_from(CreateMeetingScheduleOrganizer)
        .for(described_class)
        .with(input)
    end
    let(:errors) { executed_action.errors }

    subject(:executed_action) { described_class.execute(ctx) }

    context 'with a reasonable schedule' do
      let(:meetings) do
        [
          { name: 'Meeting 1', duration: 3, type: :onsite },
          { name: 'Meeting 2', duration: 2, type: :offsite },
          { name: 'Meeting 3', duration: 1, type: :offsite },
          { name: 'Meeting 4', duration: 0.5, type: :onsite }
        ]
      end

      it 'returns meetings ordered by duration and grouped by type' do
        expect(executed_action.success?).to be_truthy

        params = executed_action.params
        expect(params.keys).to eql(%i[meetings
                                      current_time
                                      onsite_meetings
                                      offsite_meetings])

        expect(params[:onsite_meetings].map(&:duration)).to eql([3.0, 0.5])
        expect(params[:offsite_meetings].map(&:duration)).to eql([2.0, 1.0])
      end
    end

    context 'with too many offsite meetings' do
      let(:meetings) do
        [
          { name: 'Meeting 1', duration: 4, type: :offsite },
          { name: 'Meeting 2', duration: 4, type: :offsite }
        ]
      end

      it 'fails the context and returns appropriate error message' do
        expect(executed_action.failure?).to be_truthy

        params = executed_action.params
        expect(params.keys).to include(*%i[meetings
                                           current_time
                                           onsite_meetings
                                           offsite_meetings
                                           schedule_meetings_txt])

        expect(errors).to eql(meetings: "No, can’t fit.")
        expect(params[:schedule_meetings_txt]).to eql("No, can’t fit.")
      end
    end
  end
end
