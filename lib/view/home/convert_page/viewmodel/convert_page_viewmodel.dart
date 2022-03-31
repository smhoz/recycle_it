import 'package:flutter/cupertino.dart';

import '../../../../core/init/mixin/message_mixin.dart';
import '../../../../core/model/conversion_model.dart';
import '../service/convert_page_service.dart';

enum ConvertState { idle, complete, loading }

class ConvertPageViewModel extends ChangeNotifier with MessageNotifierMixin {
  ConvertState _convertState = ConvertState.idle;
  ConvertState get convertState => _convertState;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  late final Conversion conversions;

  ConvertPageViewModel() {
    getItems();
  }

  void getItems() async {
    changeConvertState(ConvertState.loading);
    final response = await ConvertPageService.instance.getItems();
    if (response is Conversion) {
      conversions = response;
      changeConvertState(ConvertState.complete);
    } else {
      notifyError(response);
    }
  }

  changeConvertState(ConvertState convertState) {
    _convertState = convertState;
    notifyListeners();
  }

  changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
