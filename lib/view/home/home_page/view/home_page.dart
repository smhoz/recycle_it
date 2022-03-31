import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/init/theme/color/custom_colors.dart';
import '../../../../core/init/widget/bottom_bar_items.dart';
import '../viewmodel/home_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        body: IndexedStack(children: BottomBarItems.instance.pages, index: viewModel.currentIndex),
        bottomNavigationBar: AnimatedOpacity(
          duration: context.normalDuration,
          opacity: viewModel.isShowModalBottomSheet ? 0 : 1,
          child: Padding(
            padding: context.paddingMedium,
            child: _bottomNavigationBar(viewModel, context),
          ),
        ),
      );
    });
  }

  Widget _bottomNavigationBar(HomeViewModel viewModel, BuildContext context) {
    return GNav(
      selectedIndex: viewModel.currentIndex,
      tabs: BottomBarItems.instance.items,
      onTabChange: (index) {
        viewModel.changeCurrentIndex(index);
      },
      rippleColor: CustomColors.instance.bottomBarrippleColor,
      hoverColor: CustomColors.instance.bottomBarhoverColor,
      gap: 8,
      activeColor: context.themeColor.primary,
      iconSize: context.theme.appBarTheme.iconTheme?.size,
      padding: context.privateBottomBarPadding,
      duration: context.normalDuration,
      tabBackgroundColor: CustomColors.instance.tabBackgroundColor,
      color: CustomColors.instance.bottomBarColor,
    );
  }
}
