import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_weather_app/network/models/consolidated_weather.dart';
import 'package:flutter_weather_app/network/repository/base/api_response.dart';
import 'package:flutter_weather_app/network/repository/forecast/forecast_repository.dart';
import 'package:flutter_weather_app/network/repository/forecast/models/forecast_response.dart';
import 'package:flutter_weather_app/ui/screens/home/bloc/home_screen_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockForecastRepository extends Mock implements ForecastRepository {}

void main() {
  MockForecastRepository? mockForecastRepository;
  var testString = "string";
  var testStringDate = "01-01-2020";
  var testInt = 1;
  var testDouble = 1.0;

  var testConsolidatedWeather = ConsolidatedWeather(
      weatherStateName: testString,
      weatherStateAbbr: testString,
      applicableDate: testStringDate,
      minTemp: testDouble,
      maxTemp: testDouble,
      theTemp: testDouble,
      windSpeed: testDouble,
      windDirectionCompass: testString,
      airPressure: testDouble,
      humidity: testInt);

  List<ConsolidatedWeather> testList = [];
  testList.add(testConsolidatedWeather);

  var testResponse = ForecastResponse(testList, testString);

  setUp(() {
    mockForecastRepository = MockForecastRepository();
  });

  group("Get forecast data from API", () {
    blocTest<HomeScreenBloc, HomeScreenState>(
      "Successfully get data",
      build: () {
        when(mockForecastRepository!.getLocationForecast()).thenAnswer(
            (_) async => ApiResponse<ForecastResponse>.completed(testResponse));
        return HomeScreenBloc(repository: mockForecastRepository);
      },
      act: (bloc) => bloc.add(GetDataEvent()),
      expect: () => [
        LoadingVisibilityState(true),
        LoadingVisibilityState(false),
        DataLoadedState(data: testResponse, success: true)
      ],
    );

    blocTest<HomeScreenBloc, HomeScreenState>(
      "Internal Server Error when getting data",
      build: () {
        when(mockForecastRepository!.getLocationForecast()).thenAnswer(
            (_) async => ApiResponse<ForecastResponse>.error(
                message: "Internal Server Error",
                statusCode: HttpStatus.internalServerError));
        return HomeScreenBloc(repository: mockForecastRepository);
      },
      act: (bloc) => bloc.add(GetDataEvent()),
      expect: () => [
        LoadingVisibilityState(true),
        LoadingVisibilityState(false),
        DataLoadedState(success: false)
      ],
    );
  });
}
