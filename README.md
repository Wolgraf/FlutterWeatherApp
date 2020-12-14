# Flutter Weather App Demo

## First launch
1. In root:
   ```
   flutter pub get
   
   flutter pub run build_runner build
   ```

## Generating g.dart problem
1. In root:
   ```
   flutter clean
   flutter pub get
   flutter packages upgrade
   
   and finaly:
   flutter pub run build_runner build
   lub
   flutter pub run build_runner build --delete-conflicting-outputs
   ```