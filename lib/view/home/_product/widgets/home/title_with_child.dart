import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/view/home/convert_page/view/convert_page.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/components/border/custom_border_radius.dart';

class HeaderTitleWithChild extends StatelessWidget {
  final String? title;
  final Widget child;
  final Widget? trailing;

  const HeaderTitleWithChild({Key? key, this.trailing, required this.child, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.themeColor.primary,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: _textAndTrailingWidget(context),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: context.dynamicHeight(0.7),
              decoration: _boxDecoration(context),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Row _textAndTrailingWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: context.homesymetricPadding,
          child: Text(
            title ?? "",
            style: context.textTheme.headline1,
          ),
        ),
        trailing ?? const SizedBox.shrink(),
      ],
    );
  }

  BoxDecoration _boxDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.cardColor,
      borderRadius: const CustomBorderRadius.onlyTopLeftAndRightNormalCircular(),
    );
  }
}
