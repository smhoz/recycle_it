import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/components/bottom_sheet/custom_bottom_sheet.dart';
import '../../../../../core/components/button/custom_rounded_button.dart';
import '../../../../../core/components/sizedbox/page_sized_box.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/components/border/custom_border_radius.dart';

import '../../../../../core/components/text/input_field.dart';
import '../../../home_page/viewmodel/home_view_model.dart';

class ProfileField extends StatelessWidget {
  final String? textTitle;
  final String? textBody;
  final IconData? iconData;
  final Color? color;
  final Color? iconColor;
  final InputField? inputField;
  final VoidCallback? saveButtonOnPressed;
  final double? radius;

  const ProfileField({
    Key? key,
    this.radius,
    this.textTitle,
    this.saveButtonOnPressed,
    this.textBody,
    this.iconData,
    this.color,
    this.iconColor,
    this.inputField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.dynamicWidth(0.9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_circleAvatar(context), const Spacer(flex: 4), _titleAndSubTitle(context), const Spacer(flex: 10), _editButton(context)],
      ),
    );
  }

  CircleAvatar _circleAvatar(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.themeColor.secondaryContainer,
      child: Icon(
        iconData,
        color: iconColor ?? context.themeColor.primary,
        size: 24,
      ),
      radius: radius ?? 30,
    );
  }

  Column _titleAndSubTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(context),
        const PageSizedBox.lowHeightSizedBox(),
        SizedBox(
          width: context.dynamicWidth(0.5),
          child: _subTitle(context),
        ),
      ],
    );
  }

  RichText _subTitle(BuildContext context) {
    return RichText(
        textScaleFactor: 0.9,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: context.textTheme.headline3?.copyWith(color: context.themeColor.primary),
          text: textBody,
        ));
  }

  Text _title(BuildContext context) {
    return Text(
      textTitle ?? "",
      style: context.textTheme.headline3,
    );
  }

  InkWell _editButton(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<HomeViewModel>().changeIsShowModalBottomSheet(true);
        context.showBottomSheet(child: _bottomSheet(), onClosed: () => context.read<HomeViewModel>().changeIsShowModalBottomSheet(false));
      },
      child: Material(
        color: context.themeColor.secondaryContainer,
        borderRadius: CustomBorderRadius.normalCircular(),
        child: Padding(
          padding: context.paddingMedium,
          child: Icon(
            Icons.edit,
            color: context.themeColor.primary,
            size: 24,
          ),
        ),
      ),
    );
  }

  CustomBottomSheet _bottomSheet() {
    return CustomBottomSheet(
      initialSize: 0.4,
      maxSize: 0.6,
      child: inputField,
      bottomPinnedChild: CustomRoundedButton(
        title: "Kaydet",
        onTap: saveButtonOnPressed,
      ),
    );
  }
}
