# frozen_string_literal: true

module MeetingSchedulerExt
  RSpec.describe ApplicationContract do
    describe 'registered macros' do
      describe ':precision' do
        subject(:macro) { described_class.macros.resolve('precision') }

        it 'is registered' do
          expect(macro).to be_present
          expect(macro).to be_an_instance_of(Dry::Validation::Macro)
        end
      end
    end
  end
end
