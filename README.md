# Walker

A free data field for Garmin watches to provide stats for walking activities. I built it to provide more stats in a smaller format than are typically
available on running data fields (where too much information becomes impossible to digest at speed), and to focus on stats that are more relevant to
walking scenarios than running scenarios (e.g. steps). It currently tracks:

- Clock time
- Average walking pace for the current activity
- Total distance for the current activity
- Current pace (or rolling 5/10/30/60 second average by changing settings)
- Total time for current activity
- Current heart rate (or rolling 5/10/30/60 second average by changing settings)
- Steps for the current activity
- Steps for the day
- Calories for current activity
- Calories for the day
- Battery charge level with colour changing battery icon


Walker is aware of and supports device settings for distance units (KM or miles), background colours (black or white), and 12/24 hour clock mode.

## Supported Devices
- Approach S60 / S62
- Captain Marvel / Darth Vader / First Avenger / Rey
- D2 Bravo / Bravo Titanium / Charlie / Delta / Delta PX / Delta S
- Descent Mk1
- fenix 3 / 3 HR / 5 / 5 Plus / 5S / 5X / 5X Plus / 6 / 6 Pro / 6S / 6S Pro / 6X Pro / Chronos
- Forerunner 230 / 235 / 630 / 645 / 645 Music / 735xt / 935 / 945
- MARQ Adventurer / Athlete / Aviator / Captain / Commander / Driver / Expedition
- Venu
- vivoactive 3 / 3 Music / 3 Music LTE / 4 / 4S / 

*Note: Only tested in on a real fenix 5X in the field, all other watches tested only in the SDK device simulator.*

## BETA
Walker is currently in BETA

## Known Issues
- The Garmin API does not provide step count information for an activity, so Walker infers the activity step count by observing changes to the daily step count whilst the activity timer is running. This might go wrong if you measure a walking activity that crosses midnight or if you switch data fields (effectively shutting down Walker).

## Source
Walker is open source (MIT license) and it's code resides on GitHub at https://github.com/wwarby/walker

## Credits
This project borrows code and ideas from [RunnersField by kpaumann](https://github.com/kopa/RunnersField).
Thanks [kpaumann](https://apps.garmin.com/en-GB/developer/ab0f2743-88d2-4f32-9fb0-5fc8ba61e55a/apps) for open sourcing
your project and giving me a leg up in writing for the Garmin SDK.

### Icon Credits
- Icons by [Freepic](https://www.flaticon.com/authors/freepik) from [www.flaticon.com](https://www.flaticon.com)
- Flame icon by [Those Icons](https://www.flaticon.com/authors/those-icons) from [www.flaticon.com](https://www.flaticon.com/free-icon/fire_483675)


## Changelog
- 0.1.0
  - Initial alpha release