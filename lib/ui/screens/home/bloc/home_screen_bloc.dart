import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/common/resources/strings.dart';
import 'package:flutter_weather_app/network/repository/forecast/forecast_repository.dart';
import 'package:flutter_weather_app/network/repository/forecast/models/forecast_response.dart';
import 'package:logger/logger.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc({this.repository})
      : assert(repository != null),
        super(HomeScreenInitial());

  final ForecastRepository? repository;

  @override
  Stream<HomeScreenState> mapEventToState(
    HomeScreenEvent event,
  ) async* {
    if (event is LoadingVisibilityEvent) {
      yield LoadingVisibilityState(event.visible);
    } else if (event is GetDataEvent) {
      yield* _handleGetData();
    }
  }

  Stream<HomeScreenState> _handleGetData() async* {
    try {
      yield LoadingVisibilityState(true);
      var response = await repository!.getLocationForecast();
      yield LoadingVisibilityState(false);
      if (response.hasData())
        yield DataLoadedState(data: response.data!, success: true);
      else
        yield DataLoadedState(success: false);
    } catch (e, stackTrace) {
      Logger().e(Strings.error, e, stackTrace);
      yield LoadingVisibilityState(false);
    }
  }
}
