import 'package:delayed_result/delayed_result.dart';
import 'package:delayed_result_example/home/bloc/home_event.dart';
import 'package:delayed_result_example/home/bloc/home_state.dart';
import 'package:delayed_result_example/home/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;

  HomeBloc(this._homeRepository)
      : super(
          const HomeState(
            name: 'Rainbow Dash',
            greetingResult: DelayedResult.none(),
          ),
        ) {
    on<GreetingRequested>(_onGreetingRequested);
  }

  void _onGreetingRequested(
    GreetingRequested event,
    Emitter<HomeState> emit,
  ) async {
    if (state.greetingResult.isInProgress) return;
    emit(
      state.copyWith(
        greetingResult: const DelayedResult.inProgress(),
      ),
    );
    try {
      final greeting = await _homeRepository.greet(state.name);
      emit(
        state.copyWith(
          greetingResult: DelayedResult.fromValue(greeting),
        ),
      );
    } on Exception catch (ex) {
      emit(
        state.copyWith(
          greetingResult: DelayedResult.fromError(ex),
        ),
      );
    }
  }
}
