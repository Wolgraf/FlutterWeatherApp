import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/ui/widgets/unit_switcher/unit_switcher.dart';

part 'unit_switcher_event.dart';
part 'unit_switcher_state.dart';

class UnitSwitcherBloc extends Bloc<UnitSwitcherEvent, UnitSwitcherState> {
  UnitSwitcherBloc() : super(UnitSwitcherInitial());

  @override
  Stream<UnitSwitcherState> mapEventToState(
    UnitSwitcherEvent event,
  ) async* {
    if (event is UnitSelectionEvent) {
      yield UnitSelectionState(event.unit);
    }
  }
}
