import 'dart:async';

import 'package:clean_architecture_with_mvvm/presentation/common/state_renderer/state_render_impl.dart';
import 'package:rxdart/subjects.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
// Share variables and functions that will be used through any view model.

  final StreamController _inputStateStreamController =
      BehaviorSubject<FlowState>();


 @override
Sink get inputState => _inputStateStreamController.sink ;

 @override
Stream <FlowState> get outputState =>
    _inputStateStreamController.stream.map ( (flowState ) => flowState ) ;


  @override
  void dispose() {
    _inputStateStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start(); // will be called while init of view model.
  void dispose(); // will be called when viewmodel dies.

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
