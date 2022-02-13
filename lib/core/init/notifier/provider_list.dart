import 'package:hackathon_app/view/home/convert_page/viewmodel/convert_page_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../view/home/home_page/viewmodel/home_view_model.dart';
import '../../../view/home/shop_page/viewmodel/shop_view_model.dart';

class ProviderList {
  static ProviderList? _instance;
  ProviderList._();
  static ProviderList get instance => _instance ??= ProviderList._();

  List<SingleChildWidget> providerItems = [
    ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(),
    ),
    ChangeNotifierProvider<ShopViewModel>(
      create: (context) => ShopViewModel(),
    ),
    ChangeNotifierProvider<ConvertPageViewModel>(
      create: (context) => ConvertPageViewModel(),
    )
  ];
}
