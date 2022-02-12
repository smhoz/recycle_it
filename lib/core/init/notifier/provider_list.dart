import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../view/pages/home_page/viewmodel/home_view_model.dart';

class ProviderList {
  static ProviderList? _instance;
  ProviderList._();
  static ProviderList get instance => _instance ??= ProviderList._();

  List<SingleChildWidget> providerItems = [
    ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(),
    ),
  ];
}
