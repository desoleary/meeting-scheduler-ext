# frozen_string_literal: true

module MeetingScheduler
  RSpec.describe Organizer do
    let(:instance) { described_class.new(meetings) }

    describe '#organize' do
      subject(:organized_meetings) { instance.schedule_meetings }

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
          expect(organized_meetings).to eql(<<~TEXT.strip
            Yes, can fit. One possible solution would be:
            9:00 - 12:00 - Meeting 1
            12:00 - 12:30 - Meeting 4
            1:00 - 3:00 - Meeting 2
            3:30 - 4:30 - Meeting 3
          TEXT
                                           )
        end
      end

      context 'with more meetings' do
        let(:meetings) do
          [
            { name: 'Meeting 1', duration: 1.5, type: :onsite },
            { name: 'Meeting 2', duration: 2, type: :offsite },
            { name: 'Meeting 3', duration: 1, type: :onsite },
            { name: 'Meeting 4', duration: 1, type: :offsite },
            { name: 'Meeting 5', duration: 1, type: :offsite }
          ]
        end

        it 'returns meetings with least amount of trips' do
          expect(organized_meetings).to eql(<<~TEXT.strip
            Yes, can fit. One possible solution would be:
            9:00 - 10:30 - Meeting 1
            10:30 - 11:30 - Meeting 3
            12:00 - 2:00 - Meeting 2
            2:30 - 3:30 - Meeting 5
            4:00 - 5:00 - Meeting 4
          TEXT
                                           )
        end
      end

      context 'with too much offsite' do
        let(:meetings) do
          [
            { name: 'Meeting 1', duration: 4, type: :offsite },
            { name: 'Meeting 2', duration: 4, type: :offsite }
          ]
        end

        it 'returns no schedule' do
          expect(organized_meetings).to eql("No, can’t fit.")
        end
      end

      context 'with just enough time' do
        let(:meetings) do
          [
            { name: 'Meeting 1', duration: 0.5, type: :offsite },
            { name: 'Meeting 2', duration: 0.5, type: :onsite },
            { name: 'Meeting 3', duration: 2.5, type: :offsite },
            { name: 'Meeting 4', duration: 3, type: :onsite }
          ]
        end

        it 'returns meetings with least amount of trips' do
          expect(organized_meetings).to eql(<<~TEXT.strip
            Yes, can fit. One possible solution would be:
            9:00 - 12:00 - Meeting 4
            12:00 - 12:30 - Meeting 2
            1:00 - 3:30 - Meeting 3
            4:00 - 4:30 - Meeting 1
          TEXT
                                           )
        end
      end
    end
  end
end
