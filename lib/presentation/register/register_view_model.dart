import 'dart:async';
import 'package:clean_architecture_with_mvvm/presentation/base_view_model/base_view_model.dart';

class RegisterViewModel extends BaseViewModel {
  final StreamController _firstNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _lastNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _emailNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController =
      StreamController<String>.broadcast();

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _firstNameStreamController.close();
    _lastNameStreamController.close();
    _emailNameStreamController.close();
    _passwordNameStreamController.close();
    _isAllInputValidStreamController.close();

    super.dispose();
  }
}
