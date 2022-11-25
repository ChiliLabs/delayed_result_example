import 'package:delayed_result/delayed_result.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final String name;
  final DelayedResult<String> greetingResult;

  const HomeState({
    required this.name,
    required this.greetingResult,
  });

  HomeState copyWith({
    String? name,
    DelayedResult<String>? greetingResult,
  }) {
    return HomeState(
      name: name ?? this.name,
      greetingResult: greetingResult ?? this.greetingResult,
    );
  }

  @override
  List<Object> get props => [name, greetingResult];
}
