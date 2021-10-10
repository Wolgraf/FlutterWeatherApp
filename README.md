# Flutter Weather App Demo

## Intro
This demo application was created for recruitment purposes.

## Goal
Develop a Flutter application that displays weather information for a given city using the REST API ( https://www.metaweather.com/api/ ).
The location can be hardcoded.

## Acceptance criterias
- It is done when loading indicator is displayed when fetching the data,
- It is done when weather list item contains the day of the week abbreviation, weather
  condition image, min and max temperature,
- It is done when weather details contain the day of the week, weather condition name
  and image, current temperature, humidity, pressure, and wind,
- It is done when selecting a whether list item updates the details,
- It is done when weather information can be refreshed with pull to refresh gesture,
- It is done when an error screen with a retry button is shown when fetching the data fails.

![Alt text](/sketch.jpg?raw=true "Sketch")

## Extra points
- Supporting horizontal and vertical layouts,
- Changing the temperature’s unit (C/F).

## Help

### First launch
1. In root:
   ```
   flutter pub get
   
   flutter pub run build_runner build
   ```

### Generating g.dart problem
1. In root:
   ```
   flutter clean
   flutter pub get
   flutter packages upgrade
   
   and finaly:
   flutter pub run build_runner build

   or:
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
