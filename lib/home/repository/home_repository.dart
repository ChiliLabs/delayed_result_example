import 'package:delayed_result_example/home/model/greeting_exception.dart';

class HomeRepository {
  var _shouldThrow = true;

  Future<String> greet(String name) async {
    await Future.delayed(const Duration(seconds: 3));
    if (_shouldThrow) {
      _shouldThrow = false;
      throw const GreetingException(message: 'Could not say hi :(');
    }
    _shouldThrow = true;
    return 'Hey there, $name! Have a great day :)';
  }
}
