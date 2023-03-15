module MeetingScheduler
  class MeetingCollection < SimpleDelegator
    def initialize(meetings)
      meetings = meetings.map do |meeting|
        Meeting.new(meeting[:name], meeting[:duration], meeting[:type])
      end

      super(meetings.sort_by(&:duration).reverse) # sort meetings so that longest durations start first
    end

    # @return [BigDecimal] duration of meetings in hours
    def total_duration
      __getobj__.sum(&:duration)
    end
  end
end
