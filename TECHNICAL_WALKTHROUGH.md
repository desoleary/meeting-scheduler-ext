# Technical Walkthrough

#### Demonstrate schedule in action

#### Developer focus
  - Added the ability to simulate gem usage outside of project via console
  - Attempted to follow best practices regarding SOLID principles
    - Single Responsibility: each class does one thing only
    - Useful abstractions:
      - introduced collection class to manage sorting and calculations across daily meetings
      - `Organizer` separates whether or not schedule could be fit in prior to organizing the schedule
        - Could easily be extracted into two standalone classes  e.g. `CanScheduleService` and `OrganizeScheduleService`
      - made intentional use of the likes of `#to_s` in order to print information specific a meeting
  - Attempted to provide useful and opinionated defaults that could easily be configurable e.g. shorter meetings at the end of the day
  - Attempted to write meaningful tests
  - Introduced `rubocop`

#### Possible improvements / production readiness
  - Separate the calculation and organization of the schedule into separate services/actions
  - Introduce robust validation so we can fail fast and provide better context to the user
  - Introduce a more structured service layer that improves readability on the business case we are trying to solve e.g.
    - `CreateMeetingScheduleOrganizer` ~> controls the interactions between each action
      - `CreateMeetingScheduleValidatorAction`
        - In built mapping of input to desired params possibly via `dry-validation` contracts
        - errors mapped similar to active record
        - built in support for i18n
        - fields mapped into separate normalized `params` which the subsequent actions consume
      - `CanMeetingsBeScheduledAction` ~> responsible for calculating whether or not we can fit all meetings throughout the day
        - if we are unable it can add to `errors` field with context
      - `OrganizeMeetingsIntoScheduleAction` ~> responsible for organizing onsite and offsite meetings
        - any errors encountered can be added with context
  - Introduce a UI that might allow the user to opt in and out of meetings e.g. we notice we cannot schedule all today so maybe pick and choose.

#### Possible environment improvements
  - Make use of the likes of `[overcommit](https://github.com/sds/overcommit)` or `[husky](https://github.com/typicode/husky)`
  - Introduce `.editorconfig` to help maintain consistent coding styles and provides better IDE integration
  - Make use of `bullet` if we are using DB interactions in order to detect N+1 issues etc.
  - Automate tasks on GitHub
    - `Bundler Audit`
   

#### Edge cases/additional features:
  - Timezones: can handle and display time zones accurately
  - Suggest alternative time slots (maybe next day)
  - Flexible/unusual work schedule. Not all people do 9-5
  - accommodate as many participants as possible whilst being realistic. required vs optional
  - cancellations and/or rescheduling
  - Notify all participants in the case of cancellations/rescheduling/reminders
  - recurring meetings should be taking into account
  - Allow user to customize their preferences including:
    - long meetings at the start or end of day
    - focus time
