import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/button/custom_rounded_button.dart';
import '../../../../core/components/center/center_circular_indicator.dart';
import '../../../../core/components/center/center_error.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../_product/widgets/home/map_widget.dart';
import '../../_product/widgets/home/title_with_child.dart';
import '../../qr_page/view/qr_component.dart';
import '../viewmodel/home_view_model.dart';

class MapComponent extends StatelessWidget {
  const MapComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: HeaderTitleWithChild(
        title: "Home",
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _mapWidget(),
          _scanButton(context),
        ]),
      ),
    );
  }

  Consumer<HomeViewModel> _mapWidget() {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        switch (viewModel.homeViewState) {
          case HomeViewState.complete:
            return Expanded(child: MapWidget(containers: viewModel.recycleContainers));
          case HomeViewState.idle:
            return const SizedBox.shrink();
          case HomeViewState.loading:
            return const CenterCircularProgress();
          case HomeViewState.error:
            return CenterError(error: viewModel.error);
        }
      },
    );
  }

  Widget _scanButton(BuildContext context) {
    return CustomRoundedButton(
        icon: Icon(
          Icons.qr_code_scanner,
          color: context.theme.cardColor,
        ),
        title: " SCAN ",
        onTap: () => context.router.pushWidget(const QRPage()));
  }
}
