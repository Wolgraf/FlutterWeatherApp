import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_weather_app/network/api/rest_client.dart';
import 'package:flutter_weather_app/network/models/consolidated_weather.dart';
import 'package:intl/intl.dart';
import 'package:mock_web_server/mock_web_server.dart';
import 'package:test/test.dart';

MockWebServer _mockWebServer;
RestClient _restClient;

void main() {
  var testHeaders = {"Content-Type": "application/json"};

  var testString = "string";
  var testStringDate = "2020-01-01";
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

  List<ConsolidatedWeather> testList = new List();
  testList.add(testConsolidatedWeather);

  var testResponseGetLocationForecast = {
    "title": testString,
    "consolidated_weather": testList
  };

  setUp(() async {
    _mockWebServer = MockWebServer();

    await _mockWebServer.start();
    final dio = Dio();
    _restClient = RestClient(dio, baseUrl: _mockWebServer.url);
  });

  tearDown(() {
    _mockWebServer.shutdown();
  });

  test("getLocationForecast returns correct title", () async {
    _mockWebServer.enqueue(
      httpCode: 200,
      headers: testHeaders,
      body: json.encode(testResponseGetLocationForecast),
    );

    final response = await _restClient.getLocationForecast();
    expect(response.title, "string");
  });

  test("getLocationForecast returns correct single object's properWeatherName",
      () async {
    _mockWebServer.enqueue(
      httpCode: 200,
      headers: testHeaders,
      body: json.encode(testResponseGetLocationForecast),
    );

    final response = await _restClient.getLocationForecast();
    expect(response.consolidatedWeather.first.properWeatherName, "string");
  });

  test("getLocationForecast returns correct single object's weatherIconPath",
      () async {
    _mockWebServer.enqueue(
      httpCode: 200,
      headers: testHeaders,
      body: json.encode(testResponseGetLocationForecast),
    );

    final response = await _restClient.getLocationForecast();
    expect(response.consolidatedWeather.first.weatherIconPath,
        "assets/icons/string.svg");
  });

  test("getLocationForecast returns correct single object's hasIcon", () async {
    _mockWebServer.enqueue(
      httpCode: 200,
      headers: testHeaders,
      body: json.encode(testResponseGetLocationForecast),
    );

    final response = await _restClient.getLocationForecast();
    expect(response.consolidatedWeather.first.hasIcon, true);
  });

  test("getLocationForecast returns correct single object's dayDateTime",
      () async {
    _mockWebServer.enqueue(
      httpCode: 200,
      headers: testHeaders,
      body: json.encode(testResponseGetLocationForecast),
    );

    final response = await _restClient.getLocationForecast();
    expect(response.consolidatedWeather.first.dayDateTime,
        DateTime.parse(testStringDate));
  });

  test("getLocationForecast returns correct single object's dayOfTheWeekAbb",
      () async {
    _mockWebServer.enqueue(
      httpCode: 200,
      headers: testHeaders,
      body: json.encode(testResponseGetLocationForecast),
    );

    final response = await _restClient.getLocationForecast();
    expect(response.consolidatedWeather.first.dayOfTheWeekAbb,
        DateFormat("EEE").format(DateTime.parse(testStringDate)));
  });

  test("getLocationForecast returns correct single object's dayOfTheWeek",
      () async {
    _mockWebServer.enqueue(
      httpCode: 200,
      headers: testHeaders,
      body: json.encode(testResponseGetLocationForecast),
    );

    final response = await _restClient.getLocationForecast();
    expect(response.consolidatedWeather.first.dayOfTheWeek,
        DateFormat("EEEE").format(DateTime.parse(testStringDate)));
  });

  test("getLocationForecast returns correct single object's minTempText",
      () async {
    _mockWebServer.enqueue(
      httpCode: 200,
      headers: testHeaders,
      body: json.encode(testResponseGetLocationForecast),
    );

    final response = await _restClient.getLocationForecast();
    expect(response.consolidatedWeather.first.minTempText, "1.0 \u{2103}");
  });

  test("getLocationForecast returns correct single object's minTempTextFhr",
      () async {
    _mockWebServer.enqueue(
      httpCode: 200,
      headers: testHeaders,
      body: json.encode(testResponseGetLocationForecast),
    );

    final response = await _restClient.getLocationForecast();
    expect(response.consolidatedWeather.first.minTempTextFhr, "33.8 \u{2109}");
  });

  test("getLocationForecast returns correct single object's properHumidity",
      () async {
    _mockWebServer.enqueue(
      httpCode: 200,
      headers: testHeaders,
      body: json.encode(testResponseGetLocationForecast),
    );

    final response = await _restClient.getLocationForecast();
    expect(response.consolidatedWeather.first.properHumidity, "Humidity: 1 %");
  });

  test("getLocationForecast returns correct single object's properPressure",
      () async {
    _mockWebServer.enqueue(
      httpCode: 200,
      headers: testHeaders,
      body: json.encode(testResponseGetLocationForecast),
    );

    final response = await _restClient.getLocationForecast();
    expect(
        response.consolidatedWeather.first.properPressure, "Pressure: 1.0 hPa");
  });

  test("getLocationForecast returns correct single object's properWind",
      () async {
    _mockWebServer.enqueue(
      httpCode: 200,
      headers: testHeaders,
      body: json.encode(testResponseGetLocationForecast),
    );

    final response = await _restClient.getLocationForecast();
    expect(response.consolidatedWeather.first.properWind,
        "Wind: (string) 1.00 mph");
  });
}
