import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/network/models/consolidated_weather.dart';

part 'forecast_list_widget_event.dart';
part 'forecast_list_widget_state.dart';

class ForecastListWidgetBloc
    extends Bloc<ForecastListWidgetEvent, ForecastListWidgetState> {
  ForecastListWidgetBloc() : super(ForecastListWidgetInitial());

  @override
  Stream<ForecastListWidgetState> mapEventToState(
    ForecastListWidgetEvent event,
  ) async* {
    if (event is CardSelectionEvent) {
      yield CardSelectionState(event.object, event.index);
    }
  }
}
