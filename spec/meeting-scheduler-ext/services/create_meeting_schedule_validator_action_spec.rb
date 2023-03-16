# frozen_string_literal: true

module MeetingSchedulerExt
  RSpec.describe CreateMeetingScheduleValidatorAction do
    let(:overrides) { {} }
    let(:input) { { name: 'Sample Meeting', duration: 1, type: Type::ONSITE }.merge(overrides) }
    let(:ctx) { ApplicationContext.make_with_defaults(input) }
    let(:errors) { context.errors }

    subject(:context) { described_class.execute(ctx) }

    context 'with valid attributes' do
      it 'returns promised params and empty errors' do
        expect(context.success?).to be_truthy
        expect(errors).to be_empty
        expect(context[:params].keys).to eql(%i[name duration type])
      end
    end

    context 'with invalid attributes' do
      let(:overrides) { { name: nil } }

      it 'returns promised params and empty errors' do
        expect(context.failure?).to be_truthy
        expect(errors).to eql({ name: ["must be filled"] })
        expect(context[:params].keys).to eql(%i[name duration type])
      end
    end
  end
end
