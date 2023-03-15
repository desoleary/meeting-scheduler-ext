module MeetingScheduler
  RSpec.describe Meeting do
    describe "initialize" do
      subject(:meeting) { described_class.new(name, duration, type) }

      context "when valid arguments are passed" do
        let(:name) { "Weekly Team Meeting" }
        let(:duration) { BigDecimal("1.5") }
        let(:type) { :onsite }

        it "creates a new meeting object" do
          expect(meeting).to be_an_instance_of(described_class)
        end

        it "sets the name, duration, and type attributes" do
          expect(meeting.name).to eq(name)
          expect(meeting.duration).to eq(duration)
          expect(meeting.type).to eq(type)
        end
      end

      context "when an invalid type is passed" do
        let(:name) { "Invalid Meeting" }
        let(:duration) { BigDecimal("2") }
        let(:type) { :virtual }

        it "raises an ArgumentError" do
          expect do
            meeting
          end.to raise_error(ArgumentError,
                             "type: must be one of #{described_class::MEETING_TYPES.inspect}, given #{type}")
        end
      end

      context "when duration is not numeric" do
        let(:name) { "Invalid Meeting" }
        let(:duration) { "two" }
        let(:type) { :onsite }

        it "raises an ArgumentError" do
          expect { meeting }.to raise_error(ArgumentError, "duration: must be a number, given #{duration}")
        end
      end

      context "when name is blank" do
        let(:name) { "" }
        let(:duration) { BigDecimal("2") }
        let(:type) { :onsite }

        it "raises an ArgumentError" do
          expect { meeting }.to raise_error(ArgumentError, "name must be filled, given #{name}")
        end
      end
    end

    describe "MEETING_TYPES" do
      it "returns an array of two symbols" do
        expect(described_class::MEETING_TYPES).to eq(%i[onsite offsite])
      end

      it "freezes the array to prevent modification" do
        expect(described_class::MEETING_TYPES).to be_frozen
      end
    end
  end
end
