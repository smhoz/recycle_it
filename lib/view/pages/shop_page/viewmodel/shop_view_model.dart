import 'package:flutter/cupertino.dart';
import 'package:hackathon_app/view/pages/shop_page/model/entity_category.dart';

import '../../../../core/init/mixin/message_mixin.dart';
import '../service/store_service.dart';

enum ShopState { idle, complete, loading }

class ShopViewModel extends ChangeNotifier with MessageNotifierMixin {
  ShopState _shopState = ShopState.idle;
  ShopState get shopState => _shopState;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  final List<EntityCategory> itemCategories = [];

  ShopViewModel() {
    getItems();
  }

  void getItems() async {
    changeShopState(ShopState.loading);
    final response = await ShopStoreService.instance.getItems();
    if (response is List<EntityCategory<dynamic>>) {
      itemCategories.addAll(response);
      changeShopState(ShopState.complete);
    } else {
      notifyError(response);
    }
  }

  changeShopState(ShopState shopState) {
    _shopState = shopState;
    notifyListeners();
  }

  changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
