import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:clean_architecture_with_mvvm/domain/use_case/restaurant_usecase.dart';
import 'package:clean_architecture_with_mvvm/presentation/base_view_model/base_view_model.dart';
import 'package:clean_architecture_with_mvvm/presentation/common/state_renderer/state_render_impl.dart';
import 'package:clean_architecture_with_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:rxdart/subjects.dart';

import '../../../domain/model/model.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  // ===>> this is boradcast stream controller
  // final _restaurantStreamController = BehaviorSubject<List<Restaurant>>();
  StreamController _bannersStreamController =
      BehaviorSubject<List<Restaurant>>();
  StreamController _servicesStreamController =
      BehaviorSubject<List<Restaurant>>();
  StreamController _storesStreamController =
      BehaviorSubject<List<Restaurant>>();

  final RestaurantUseCase _useCase;
  HomeViewModel(this._useCase);

  @override
  void start() {
    _getHome();
  }

  _getHome() async {
    log("jellp");
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));

    (await _useCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
    }, (homeObject) {
      inputState.add(ContentState());
      inputRestaurant.add(homeObject.data);
      log("_getHome ${homeObject.data.length}");
      // inputServices.add(homeObject.data.services);
      // inputStores.add(homeObject.data.stores);
    });
  }

  @override
  void dispose() {
    _bannersStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputRestaurant => _bannersStreamController.sink;

  @override
  Stream<List<Restaurant>> get outputRestaurant =>
      _bannersStreamController.stream.map((restaurant) {
        log("stream ${restaurant}");
        return restaurant;
      });
}

abstract class HomeViewModelInput {
  Sink get inputRestaurant;
}

abstract class HomeViewModelOutput {
  Stream<List<Restaurant>> get outputRestaurant;
}