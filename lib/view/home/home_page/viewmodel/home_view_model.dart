import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
