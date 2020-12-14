import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_weather_app/common/resources/constants.dart';
import 'package:flutter_weather_app/network/repository/forecast/models/forecast_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: API_BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/api/location/$LOCATION_WOEID/")
  Future<ForecastResponse> getLocationForecast();
}