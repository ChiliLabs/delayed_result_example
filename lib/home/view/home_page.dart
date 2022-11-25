import 'package:delayed_result_example/home/bloc/home_bloc.dart';
import 'package:delayed_result_example/home/bloc/home_event.dart';
import 'package:delayed_result_example/home/bloc/home_state.dart';
import 'package:delayed_result_example/home/model/greeting_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(context.read()),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  late HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final result = state.greetingResult;
          final isProgress = result.isInProgress;
          if (isProgress) {
            return const _GreetingStatus(
              status: 'Requesting greeting...',
              child: CircularProgressIndicator(),
            );
          }

          final error =
              result.isError ? _mapExceptionToError(result.error) : null;

          final isError = error != null;
          if (isError) {
            return _GreetingStatus(
              status: error,
              child: ElevatedButton(
                onPressed: _requestGreeting,
                child: const Text('Retry'),
              ),
            );
          }

          final isNone = result.isNone;
          final value = result.value;

          if (isNone || value == null) {
            return _GreetingStatus(
              status: 'No greeting yet',
              child: ElevatedButton(
                onPressed: _requestGreeting,
                child: const Text('Request greeting'),
              ),
            );
          }

          return _GreetingStatus(
            status: value,
            child: ElevatedButton(
              onPressed: _requestGreeting,
              child: const Text('Request another greeting'),
            ),
          );
        },
      ),
    );
  }

  void _requestGreeting() {
    _bloc.add(const GreetingRequested());
  }

  String? _mapExceptionToError(Exception? ex) {
    if (ex == null) {
      return null;
    } else if (ex is GreetingException) {
      return ex.message;
    }
    return 'Something went wrong';
  }
}

class _GreetingStatus extends StatelessWidget {
  final String status;
  final Widget child;

  const _GreetingStatus({
    Key? key,
    required this.status,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(status),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
