# frozen_string_literal: true

module MeetingSchedulerExt
  RSpec.describe CreateMeetingScheduleContract do
    include Dry::Validation::Matchers

    let(:name) { 'Sample Meeting' }
    let(:duration) { 1 }
    let(:type) { Type::ONSITE }
    let(:input) do
      { meetings: [{ name: name, duration: duration, type: type }] }
    end
    let(:validated_contract) { described_class.new.call(input) }
    let(:errors) { validated_contract.errors.to_h }

    describe 'params' do
      describe 'type' do
        context 'with unexpected type' do
          let(:type) { :unexpected_type }

          it 'returns error messages' do
            expect(validated_contract).to be_failure
            expect(errors).to include(meetings: { 0 => { type: ["must be one of: onsite, offsite"] } })
          end
        end
      end
    end

    describe 'rules' do
      describe 'duration' do
        let(:duration) { 1.253 }

        it 'is invalid with excessive precision' do
          expect(validated_contract).to be_failure
          expect(errors).to include(meetings: { 0 => ["number of decimal number places must not exceed 2"] })
        end

        context 'without duration' do
          let(:duration) { nil }

          it 'returns error messages' do
            expect(validated_contract).to be_failure
            expect(errors).to include(meetings: { 0 => { duration: ["must be filled"] } })
          end
        end
      end
    end
  end
end

