import 'package:flutter_weather_app/network/repository/base/api_response.dart';
import 'package:flutter_weather_app/network/repository/base/base_repository.dart';

import 'models/forecast_response.dart';

class ForecastRepository extends BaseRepository {
  Future<ApiResponse<ForecastResponse>> getLocationForecast() async {
    try {
      var response = await restClient.getLocationForecast();
      return ApiResponse.completed(response);
    } catch (e, stackTrace) {
      return handleException<ForecastResponse>(e, stackTrace);
    }
  }
}
