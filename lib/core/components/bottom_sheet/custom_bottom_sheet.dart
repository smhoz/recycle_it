import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view/home/home_page/viewmodel/home_view_model.dart';
import '../../extensions/context_extension.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget? child;
  final double initialSize;
  final double maxSize;
  final Widget bottomPinnedChild;
  const CustomBottomSheet({
    Key? key,
    this.child,
    this.initialSize = 0.5,
    this.maxSize = 1.0,
    this.bottomPinnedChild = const SizedBox(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DraggableScrollableSheet(
          initialChildSize: initialSize >= 0.25 ? initialSize : 0.25,
          maxChildSize: maxSize,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: _boxDecoration(context),
              child: Column(
                children: [
                  _topBackButton(context),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: child,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Align(
          child: bottomPinnedChild,
          alignment: Alignment.bottomCenter,
        ),
      ],
    );
  }

  InkWell _topBackButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        context.read<HomeViewModel>().changeIsShowModalBottomSheet(false);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Container(
          decoration: _backButtonBoxDecoration(context),
          height: context.lowHeight,
          width: context.highHeight,
        ),
      ),
    );
  }

  BoxDecoration _backButtonBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.themeColor.primary.withOpacity(0.6),
      borderRadius: BorderRadius.circular(12),
    );
  }

  BoxDecoration _boxDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.canvasColor,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      boxShadow: [
        BoxShadow(
          color: context.theme.focusColor,
          offset: const Offset(0, -1),
          blurRadius: 3,
          spreadRadius: 3,
        )
      ],
    );
  }
}
