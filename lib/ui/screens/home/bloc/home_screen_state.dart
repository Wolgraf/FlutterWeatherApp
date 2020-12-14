part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();
}

class HomeScreenInitial extends HomeScreenState {
  @override
  List<Object> get props => [];
}

class DataLoadedState extends HomeScreenState {
  const DataLoadedState({this.data, this.success});
  final ForecastResponse data;
  final bool success;

  @override
  List<Object> get props => [data, success];
}

class LoadingVisibilityState extends HomeScreenState {
  LoadingVisibilityState(this.visible);

  final bool visible;

  @override
  List<Object> get props => [visible];
}
