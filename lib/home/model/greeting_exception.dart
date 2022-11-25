import 'package:equatable/equatable.dart';

class GreetingException extends Equatable implements Exception {
  final String message;

  const GreetingException({required this.message});

  @override
  List<Object?> get props => [message];
}
