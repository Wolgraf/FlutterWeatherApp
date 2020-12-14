part of 'unit_switcher_bloc.dart';

abstract class UnitSwitcherEvent extends Equatable {
  const UnitSwitcherEvent();

  @override
  List<Object> get props => [];
}

class UnitSelectionEvent extends UnitSwitcherEvent {
  UnitSelectionEvent(this.unit);

  final Unit unit;

  @override
  List<Object> get props => [unit];
}
