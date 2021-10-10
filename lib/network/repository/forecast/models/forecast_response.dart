import 'package:flutter_weather_app/network/models/consolidated_weather.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forecast_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ForecastResponse {
  @JsonKey(name: "consolidated_weather")
  List<ConsolidatedWeather> consolidatedWeather;
  String title;

  ForecastResponse(this.consolidatedWeather, this.title);

  get city => title;

  factory ForecastResponse.fromJson(Map<String, dynamic> json) =>
      _$ForecastResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastResponseToJson(this);
}
