import 'package:flutter/cupertino.dart';

import '../../../../core/init/mixin/message_mixin.dart';
import '../../../../core/model/container_model.dart';
import '../service/home_service.dart';

enum HomeViewState { idle, complete, loading, error }

class HomeViewModel extends ChangeNotifier with MessageNotifierMixin {
  HomeViewState _homeViewState = HomeViewState.idle;

  HomeViewState get homeViewState => _homeViewState;
  int _currentIndex = 0;

  bool _isShowModalBottomSheet = false;

  bool get isShowModalBottomSheet => _isShowModalBottomSheet;

  int get currentIndex => _currentIndex;

  List<RecycleContainer> recycleContainers = [];

  HomeViewModel() {
    getContainers();
  }

  void getContainers() async {
    changeHomeState(HomeViewState.loading);
    var response = await HomeStoreService.instance.getContainers();

    if (response is List<RecycleContainer>) {
      recycleContainers.addAll(response);
      changeHomeState(HomeViewState.complete);
    } else {
      changeHomeState(HomeViewState.error);
      notifyError(response);
    }
  }

  void changeCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  changeHomeState(HomeViewState homeViewState) {
    _homeViewState = homeViewState;
    notifyListeners();
  }

  void changeIsShowModalBottomSheet(bool value) {
    _isShowModalBottomSheet = value;
    notifyListeners();
  }
}
