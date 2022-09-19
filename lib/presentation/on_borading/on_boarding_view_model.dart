import 'dart:async';

import 'package:clean_architecture_with_mvvm/domain/model/model.dart';
import 'package:clean_architecture_with_mvvm/presentation/base_view_model/base_view_model.dart';

import '../resources/asset_manager.dart';
import '../resources/string_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int currentIndex = 0;

  // ................ input ................
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    // post data to our view
    _postDataToView();
  }

  @override
  int goNext() {
    int index = currentIndex++;
    if (index >= _list.length) {
      currentIndex = 0;
    }

    return currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = currentIndex--;
    if (previousIndex == -1) {
      currentIndex = _list.length - 1;
    }
    return currentIndex;
  }

  @override
  void onPageChanges(int index) {
    currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  //................ output...................
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // ................Private functions ................

  List<SliderObject> _getSliderData() => [
        SliderObject(AppString.onBoardingTitle1, AppString.onBoardingSubTitle1,
            AssetManager.onBoardingLogo1),
        SliderObject(AppString.onBoardingTitle2, AppString.onBoardingSubTitle2,
            AssetManager.onBoardingLogo2),
        SliderObject(AppString.onBoardingTitle3, AppString.onBoardingSubTitle3,
            AssetManager.onBoardingLogo3),
        SliderObject(AppString.onBoardingTitle4, AppString.onBoardingSubTitle4,
            AssetManager.onBoardingLogo4),
      ];

  void _postDataToView() {
    inputSliderViewObject
        .add(SliderViewObject(_list[currentIndex], _list.length, currentIndex));
  }
}

// inputs mean the order that our view model will receive from out view.
abstract class OnBoardingViewModelInputs {
  int goNext(); // when user click on right arrow or swipe left.
  int goPrevious(); // when user click on left arrow or swipe right.
  void onPageChanges(int index); // when page changing.

  Sink
      get inputSliderViewObject; // in this way to add data to the stream .. stram input
}

// outputs mean data or result that will be sent from our viewmodel to our view.
abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

// Slider data class
class SliderViewObject {
  final SliderObject sliderObject;
  final int slideNumber;
  final int currentIndex;

  SliderViewObject(this.sliderObject, this.slideNumber, this.currentIndex);
}
