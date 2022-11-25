import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GreetingRequested extends HomeEvent {
  const GreetingRequested();

  @override
  List<Object> get props => [];
}
