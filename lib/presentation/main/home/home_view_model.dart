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
  final _restaurantStreamController = BehaviorSubject<RestaurantResult>();
  // StreamController _bannersStreamController =
  //     BehaviorSubject<List<Restaurant>>();
  // StreamController _servicesStreamController =
  //     BehaviorSubject<List<Restaurant>>();
  // StreamController _storesStreamController =
  //     BehaviorSubject<List<Restaurant>>();

  final RestaurantUseCase _useCase;
  HomeViewModel(this._useCase);

  @override
  void start() {
    _getHome();
  }

  

  _getHome() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));

    (await _useCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
    }, (homeObject) {
      inputState.add(ContentState());
      inputRestaurant.add(homeObject);
    });
  }

  @override
  void dispose() {
    _restaurantStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputRestaurant => _restaurantStreamController.sink;

  @override
  Stream<RestaurantResult> get outputRestaurant =>
      _restaurantStreamController.stream.map((restaurant) {
        log("stream $restaurant");
        return restaurant;
      });
}

abstract class HomeViewModelInput {
  Sink get inputRestaurant;
}

abstract class HomeViewModelOutput {
  Stream<RestaurantResult> get outputRestaurant;
}
