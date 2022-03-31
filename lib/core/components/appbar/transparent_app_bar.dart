import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/core/components/sizedbox/page_sized_box.dart';

import '../../../../core/extensions/context_extension.dart';

class TransparentAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final String? subTitle;
  final Color? color;
  final Widget? child;
  final Color? backgroundColor;

  const TransparentAppBar({Key? key, this.subTitle, this.backgroundColor, this.title, this.color, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? context.themeColor.primary,
      leading: IconButton(onPressed: () => context.router.pop(), icon: const Icon(Icons.arrow_back_ios_new_outlined)),
      elevation: 0,
      title: _titleAndSubtitle(context, title, subTitle),
      actions: [
        Padding(
          padding: context.onlyRightPaddingMedium,
          child: child ?? const SizedBox.shrink(),
        )
      ],
    );
  }

  Column _titleAndSubtitle(BuildContext context, String? title, String? subTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? "",
          style: context.textTheme.bodyText1,
        ),
        const PageSizedBox.lowHeightSizedBox(),
        Text(
          subTitle ?? "",
          style: context.textTheme.headline5,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
