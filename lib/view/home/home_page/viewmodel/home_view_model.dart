import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier {
  int _currentIndex = 0;

  bool _isShowModalBottomSheet = false;

  bool get isShowModalBottomSheet => _isShowModalBottomSheet;

  int get currentIndex => _currentIndex;

  void changeCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void changeIsShowModalBottomSheet(bool value) {
    _isShowModalBottomSheet = value;
    notifyListeners();
  }
}
