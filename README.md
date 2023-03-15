# MeetingScheduler

## MajorClarity by Paper

### Technical Exercise

Your product owner is asking you to implement a new feature in the calendar
system that is in your scheduling tool. The feature needs to support arranging a
set of meetings within an 8 hour day in a way that makes them work, and let the
user know if the meetings cannot fit into the day.


For this feature there will be two kinds of meetings, on-site meetings and off-site
meetings. On-site meetings can be scheduled back to back with no gaps in
between them, but off-site meetings must have 30 minutes of travel time padded
to either end. This travel time however can overlap for back to back off-site
meetings, and can extend past the start and end of the day.


Given a set of meetings (below is an example of a set of meetings):

```ruby
[
{ name: 'Meeting 1', duration: 3, type: :onsite },
{ name: 'Meeting 2', duration: 2, type: :offsite },
{ name: 'Meeting 3', duration: 1, type: :offsite },
{ name: 'Meeting 4', duration: 0.5, type: :onsite }
]
```

You must write code to determine if these meetings can fit into a 9 to 5
schedule, and propose a layout for those meetings in a format like this:

```rhtml
9:00 - 12:00 - Meeting 1
12:00 - 12:30 - Meeting 4
1:00 - 3:00 - Meeting 2
3:30 - 4:30 - Meeting 3
```

Here are a few example sets for you to test against:

Example 1:

```ruby
[
{ name: 'Meeting 1', duration: 1.5, type: :onsite },
{ name: 'Meeting 2', duration: 2, type: :offsite },
{ name: 'Meeting 3', duration: 1, type: :onsite },
{ name: 'Meeting 4', duration: 1, type: :offsite },
{ name: 'Meeting 5', duration: 1, type: :offsite },
]
```

```rhtml
Yes, can fit. One possible solution would be:
9:00 - 10:30 - Meeting 1
10:30 - 11:30 - Meeting 3
12:00 - 1:00 - Meeting 5
1:30 - 2:30 - Meeting 4
3:00 - 5:00 - Meeting 2
```

Example 2:

```ruby
[
{ name: “Meeting 1”, duration: 4, type: :offsite },
{ name: “Meeting 2”, duration: 4, type: :offsite }
]
```

No, can’t fit.


Example 3:

```ruby
[
{ name: 'Meeting 1', duration: 0.5, type: :offsite },
{ name: 'Meeting 2', duration: 0.5, type: :onsite },
{ name: 'Meeting 3', duration: 2.5, type: :offsite },
{ name: 'Meeting 4', duration: 3, type: :onsite }
]
```

```rhtml
Yes, can fit. One possible solution would be:
9:00 - 9:30 - Meeting 2
10:00 - 10:30 - Meeting 1
11:00 - 2:00 - Meeting 4
```

## Installation

Add this line to your application's Gemfile:

```shell
$ git clone git@github.com:desoleary/meeting-scheduler.git
$ cd meeting-scheduler
$ bundle install
$ bin/rspec
```

## Console
run `irb -r ./dev/setup` for an interactive prompt.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/meeting_scheduler. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/meeting_scheduler/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MeetingScheduler project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/meeting_scheduler/blob/master/CODE_OF_CONDUCT.md).
