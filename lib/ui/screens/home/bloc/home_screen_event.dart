part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object> get props => [];
}

class GetDataEvent extends HomeScreenEvent {}

class LoadingVisibilityEvent extends HomeScreenEvent {
  LoadingVisibilityEvent(this.visible);

  final bool visible;

  @override
  List<Object> get props => [visible];
}
