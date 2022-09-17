import 'package:clean_architecture_with_mvvm/presentation/base_view_model/base_view_model.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  // input
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement
  }

  @override
  void goNext() {
    // TODO: implement goNext start
  }

  @override
  void goPrevious() {
    // TODO: implement goPrevious
  }

  @override
  void onPageChanges(int index) {
    // TODO: implement onPageChanges
  }
}

// inputs mean the order that our view model will receive from out view.
abstract class OnBoardingViewModelInputs {
  void goNext(); // when user click on right arrow or swipe left.

  void goPrevious(); // when user click on left arrow or swipe right.

  void onPageChanges(int index); // when page changing
}

// outputs mean data or result that will be sent from our viewmodel to our view.
abstract class OnBoardingViewModelOutputs {
  // will be implement letter
}
