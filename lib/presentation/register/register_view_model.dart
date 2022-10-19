import 'dart:async';
import 'package:clean_architecture_with_mvvm/presentation/base_view_model/base_view_model.dart';

class RegisterViewModel extends BaseViewModel {
  StreamController firstNameStreamController = StreamController<String>.broadcast();
  StreamController lastNameStreamController = StreamController<String>.broadcast();
  StreamController emailNameStreamController = StreamController<String>.broadcast();
  StreamController passwordNameStreamController = StreamController<String>.broadcast();
  
  
  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
