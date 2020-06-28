# Walker

A free data field for Garmin watches to provide stats for walking activities. Built to provide more data in a more compact format than is typically available on data fields designed for runners (where too much information becomes impossible to digest at speed). Walker is focused on data relevant to casual walking scenarios where step count, distance, pace and calorie burn are the predominant concerns rather than hiking where bearing, ascent and altitude etc. are more relevant. It currently displays:

- Clock time
- Average pace for the current activity
- Total distance for the current activity
- Current pace (or rolling 5/10/30/60 second average by changing settings)
- Total time for current activity
- Current heart rate (or rolling 5/10/30/60 second average by changing settings)
- Current heart rate zone and heart icon coloured by zone (if enabled in settings - disabled by default)
- Steps for the current activity
- Steps for today
- Calories for current activity
- Calories for today
- Battery charge level with colour changing battery icon
- Progress bar showing progress towards step goal (if step goal is set)

Walker also contributes step data to the FIT profile for your activity, showing total steps and lap steps in the activity summary in Garmin Connect.

Walker is aware of and supports device settings for distance units (KM or miles), background colours (black or white), and 12/24 hour clock mode.

Feature suggestions are welcome and will be considered.

<img src="/supporting-files/screenshots/screenshot-1.png" height="300" alt="Screenshot Dark"></img> <img src="/supporting-files/screenshots/screenshot-4.png" height="300" alt="Screenshot Light"></img>

## Supported Devices
- Approach S60 / S62
- Captain Marvel / Darth Vader / First Avenger / Rey
- D2 Bravo / Bravo Titanium / Charlie / Delta / Delta PX / Delta S
- Descent Mk1
- fenix 3 / 3 HR / 5 / 5 Plus / 5S / 5X / 5X Plus / 6 / 6 Pro / 6S / 6S Pro / 6X Pro / Chronos
- Forerunner 230 / 235 / 630 / 645 / 645 Music / 735xt / 935 / 945
- MARQ Adventurer / Athlete / Aviator / Captain / Commander / Driver / Expedition
- Venu
- vivoactive 3 / 3 Music / 3 Music LTE / 4 / 4S

*Note: Only tested in on a real fenix 5X in the field, all other watches tested only in the SDK device simulator.*

## Supported Languages
- Czech
- Danish
- Dutch
- English
- French
- German
- Italian
- Norwegian
- Polish
- Portuguese
- Romanian
- Russian
- Spanish
- Swedish

Help with internationalisation would be welcomed. Current translations are based on Reverso and Google Translate. I've made an effort to find the correct translations but have no easy way of finding out if they are correct except through user feedback. More languages may be added in future if requested.

## BETA
Walker is currently in BETA, having had only minimal field testing on a couple of watches. It has been tested in the Garmin simulator against all supported devices and seems relatively stable, but please get in touch if you find any bugs. The current activity step count in particular is in need of thorough testing, through pause/unpause cycles, crossing midnight (because the daily step counter resets at midnight) etc. This is because the Garmin API doesn't provide step data for activities, so this value has been calculated by observing the daily step counter whilst the activity timer is running, and there is plenty of scope for gremlins there.

## Source
Walker is open source (MIT license) and it's code resides on GitHub at https://github.com/wwarby/walker

## Credits
This project borrows code and ideas from [RunnersField by kpaumann](https://github.com/kopa/RunnersField).
Thanks [kpaumann](https://apps.garmin.com/en-GB/developer/ab0f2743-88d2-4f32-9fb0-5fc8ba61e55a/apps) for open sourcing
your project and giving me a leg up in writing for the Garmin SDK.

FIT contribution implementation borrows ideas and some of the implementation from [steps2fit by rgergely](https://github.com/rgergely/steps2fit).
Thanks also to [rgergely](https://apps.garmin.com/en-GB/developer/ab0f2743-88d2-4f32-9fb0-5fc8ba61e55a/apps) for open sourcing your project.

### Icon Credits
- Icons by [Freepic](https://www.flaticon.com/authors/freepik) from [www.flaticon.com](https://www.flaticon.com)
- Flame icon by [Those Icons](https://www.flaticon.com/authors/those-icons) from [www.flaticon.com](https://www.flaticon.com/free-icon/fire_483675)

## Changelog
- 0.5.0
  - Use larger fonts where possible on all devices
  - Make daily steps and calories text darker on white backgrounds
  - Add support for new watch models
- 0.4.1
  - Fix battery icon position bug on 240x240px screens
- 0.4.0
  - Add heart rate zone (configured by setting, disabled by default) to heart icon
  - Colour heart icon by heart rate zone
- 0.3.0
  - Add FIT contribution for steps
  - Support for "resume later" on activities
  - Localised language support for several European languages
  - Fix bug that would reset activity steps on activity "stop" (as opposed to "reset")
  - Memory usage optimisation
- 0.2.0
  - Add step goal progress bar
  - Hopefully support stable transition across midnight boundary for step counter
  - Optimised images for compression efficiency
  - Screenshots for Garmin Store
- 0.1.0
  - Initial alpha release
