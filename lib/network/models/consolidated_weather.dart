import 'package:flutter_weather_app/common/resources/constants.dart';
import 'package:flutter_weather_app/common/resources/strings.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';

part 'consolidated_weather.g.dart';

@JsonSerializable(explicitToJson: true)
class ConsolidatedWeather {
  @JsonKey(name: 'weather_state_name')
  String weatherStateName;
  @JsonKey(name: 'weather_state_abbr')
  String weatherStateAbbr;
  @JsonKey(name: 'applicable_date')
  String applicableDate;
  @JsonKey(name: 'min_temp')
  double minTemp;
  @JsonKey(name: 'max_temp')
  double maxTemp;
  @JsonKey(name: 'the_temp')
  double theTemp;
  @JsonKey(name: 'wind_speed')
  double windSpeed;
  @JsonKey(name: 'wind_direction_compass')
  String windDirectionCompass;
  @JsonKey(name: 'air_pressure')
  double airPressure;
  int humidity;

  get properWeatherName => weatherStateName ?? '';

  get weatherIconPath => '$ICONS_PATH$weatherStateAbbr.svg';

  get hasIcon => weatherStateAbbr != null;

  get dayDateTime {
    try {
      return DateTime.parse(applicableDate);
    } catch (e, stackTrace) {
      Logger().e(Strings.error, e, stackTrace);
      return DateTime.now();
    }
  }

  get dayOfTheWeekAbb {
    try {
      return DateFormat(DAY_OF_THE_WEEK_ABBREVIATION).format(dayDateTime);
    } catch (e, stackTrace) {
      Logger().e(Strings.error, e, stackTrace);
      return '';
    }
  }

  get dayOfTheWeek {
    try {
      return DateFormat(DAY_OF_THE_WEEK).format(dayDateTime);
    } catch (e, stackTrace) {
      Logger().e(Strings.error, e, stackTrace);
      return '';
    }
  }

  get dayOfTheWeekWithDate => '$dayOfTheWeek, $applicableDate';

  get minTempText =>
      minTemp != null ? minTemp.toStringAsFixed(1) + ' $UNIT_CELSIUS' : '-';

  get minTempTextFhr => minTemp != null
      ? convertToFhr(minTemp).toStringAsFixed(1) + ' $UNIT_FAHRENHEIT'
      : '-';

  get maxTempText =>
      maxTemp != null ? maxTemp.toStringAsFixed(1) + ' $UNIT_CELSIUS' : '-';

  get maxTempTextFhr => maxTemp != null
      ? convertToFhr(maxTemp).toStringAsFixed(1) + ' $UNIT_FAHRENHEIT'
      : '-';

  get theTempText =>
      theTemp != null ? theTemp.toStringAsFixed(1) + ' $UNIT_CELSIUS' : '-';

  get theTempTextFhr => theTemp != null
      ? convertToFhr(theTemp).toStringAsFixed(1) + ' $UNIT_FAHRENHEIT'
      : '-';

  get cardTemperatures =>
      '${Strings.min} $minTempText\n${Strings.max} $maxTempText';

  get cardTemperaturesFhr =>
      '${Strings.min} $minTempTextFhr\n${Strings.max} $maxTempTextFhr';

  get detailsTemperature => '${Strings.current_temperature} $theTempText';

  get detailsTemperatureFhr => '${Strings.current_temperature} $theTempTextFhr';

  get properHumidity => '${Strings.humidity} ${humidity ?? 0} $UNIT_HUMIDITY';

  get properPressure =>
      '${Strings.pressure} ${airPressure ?? 0} $UNIT_PRESSURE';

  get properWind => windSpeed != null
      ? '${Strings.wind} (${windDirectionCompass ?? ''}) ${windSpeed.toStringAsFixed(2)} $UNIT_WIND_SPEED'
      : '0';

  ConsolidatedWeather(
      {this.weatherStateName,
      this.weatherStateAbbr,
      this.applicableDate,
      this.minTemp,
      this.maxTemp,
      this.theTemp,
      this.windSpeed,
      this.windDirectionCompass,
      this.airPressure,
      this.humidity});

  convertToFhr(double celsius) => (celsius ?? 0) * 1.8 + 32.0;

  factory ConsolidatedWeather.fromJson(Map<String, dynamic> json) =>
      _$ConsolidatedWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$ConsolidatedWeatherToJson(this);
}
