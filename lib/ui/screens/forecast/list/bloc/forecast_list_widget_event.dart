part of 'forecast_list_widget_bloc.dart';

abstract class ForecastListWidgetEvent extends Equatable {
  const ForecastListWidgetEvent();

  @override
  List<Object> get props => [];
}

class CardSelectionEvent extends ForecastListWidgetEvent {
  CardSelectionEvent(this.object, this.index);

  final ConsolidatedWeather object;
  final int index;

  @override
  List<Object> get props => [object, index];
}
