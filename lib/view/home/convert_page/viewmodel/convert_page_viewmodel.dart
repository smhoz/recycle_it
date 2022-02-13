import 'package:flutter/cupertino.dart';
import 'package:hackathon_app/core/init/mixin/message_mixin.dart';
import 'package:hackathon_app/core/model/conversion_model.dart';
import 'package:hackathon_app/view/home/convert_page/service/convert_page_service.dart';

enum ConvertState { idle, complete, loading }

class ConvertPageViewModel extends ChangeNotifier with MessageNotifierMixin {
  ConvertState _convertState = ConvertState.idle;
  ConvertState get convertState => _convertState;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  late final Conversion conversions;

  ConvertPageViewModel() {}

  void getItems(String? id) async {
    changeConvertState(ConvertState.loading);
    final response = await ConvertPageService.instance.getItems(id!);
    print(response);
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
