import 'package:flutter/cupertino.dart';
import 'package:hackathon_app/core/model/recyclable_model.dart';

class ContainerViewModel extends ChangeNotifier {
  int tapIndex = -1;
  Recyclable? recyclable;

  void changeTapIndex(int index) {
    tapIndex = index;
    notifyListeners();
  }
}
