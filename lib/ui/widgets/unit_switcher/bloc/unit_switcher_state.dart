part of 'unit_switcher_bloc.dart';

abstract class UnitSwitcherState extends Equatable {
  const UnitSwitcherState();
}

class UnitSwitcherInitial extends UnitSwitcherState {
  @override
  List<Object> get props => [];
}

class UnitSelectionState extends UnitSwitcherState {
  UnitSelectionState(this.unit);

  final Unit unit;

  @override
  List<Object> get props => [unit];
}
