import 'package:flutter/material.dart';
import 'package:hackathon_app/core/extensions/context_extension.dart';
import 'package:hackathon_app/core/init/widget/bottom_bar_items.dart';
import 'package:hackathon_app/view/pages/home_page/viewmodel/home_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          body: IndexedStack(
            children: BottomBarItems.instance.pages,
            index: viewModel.currentIndex,
          ),
          bottomNavigationBar: BottomNavigationBar(
              items: BottomBarItems.instance.items,
              currentIndex: viewModel.currentIndex,
              selectedItemColor: context.themeColor.primary,
              onTap: (index) {
                viewModel.changeCurrentIndex(index);
              }),
        );
      },
    );
  }
}
