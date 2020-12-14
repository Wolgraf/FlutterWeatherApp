part of 'forecast_list_widget_bloc.dart';

abstract class ForecastListWidgetState extends Equatable {
  const ForecastListWidgetState();

  @override
  List<Object> get props => [];
}

class ForecastListWidgetInitial extends ForecastListWidgetState {}

class CardSelectionState extends ForecastListWidgetState {
  CardSelectionState(this.object, this.index);

  final ConsolidatedWeather object;
  final int index;

  @override
  List<Object> get props => [object, index];
}
