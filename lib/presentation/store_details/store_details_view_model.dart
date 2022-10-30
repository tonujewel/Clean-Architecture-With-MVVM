import 'dart:async';

import 'package:clean_architecture_with_mvvm/domain/model/model.dart';
import 'package:clean_architecture_with_mvvm/domain/use_case/restaurant_detail_use_case.dart';
import 'package:clean_architecture_with_mvvm/presentation/base_view_model/base_view_model.dart';
import 'package:rxdart/subjects.dart';

import '../common/state_renderer/state_render_impl.dart';
import '../common/state_renderer/state_renderer.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final StreamController _restaurantDetailsStreamController =
      BehaviorSubject<RestaurantDetailsResult>();

  final RestaurantDetailUseCase _restaurantDetailUseCase;

  StoreDetailsViewModel(this._restaurantDetailUseCase);

  late int idData;

  @override
  void start() {
    _getRestaurant();
  }

  @override
  void getId(int id) {
    idData = id;
  }

  _getRestaurant() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));

    (await _restaurantDetailUseCase.execute(idData)).fold((failure) {
      inputState.add(ErrorState(
          StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
    }, (homeObject) {
      inputState.add(ContentState());
      inputRestaurantDetails.add(homeObject);
    });
  }

  @override
  void dispose() {
    _restaurantDetailsStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputRestaurantDetails => _restaurantDetailsStreamController.sink;

  @override
  Stream<RestaurantDetailsResult> get outputRestaurantDetails =>
      _restaurantDetailsStreamController.stream
          .map((restaurantDetails) => restaurantDetails);
}

abstract class StoreDetailsViewModelInput {
  Sink get inputRestaurantDetails;

  getId(int id);
}

abstract class StoreDetailsViewModelOutput {
  Stream<RestaurantDetailsResult> get outputRestaurantDetails;
}
