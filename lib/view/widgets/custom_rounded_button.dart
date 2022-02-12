import 'package:flutter/material.dart';
import '../../core/extensions/context_extension.dart';

class CustomRoundedButton extends StatelessWidget {
  final String? title;
  final Icon? icon;
  final VoidCallback? onTap;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  const CustomRoundedButton({
    Key? key,
    this.title,
    this.onTap,
    this.icon,
    this.borderRadius = 64,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 64),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(borderRadius!),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.theme.primaryColor,
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          child: TextButton.icon(
            onPressed: onTap,
            icon: icon ??
                Icon(
                  Icons.arrow_forward_ios,
                  color: context.theme.cardColor,
                ),
            label: Text(
              title!,
              style: context.textTheme.bodyText1!.copyWith(
                letterSpacing: 2,
                color: context.theme.cardColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
