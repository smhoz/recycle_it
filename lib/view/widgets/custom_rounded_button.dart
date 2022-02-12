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
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          child: TextButton.icon(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius!),
                ),
              ),
              overlayColor: MaterialStateProperty.all(
                  Colors.grey.shade300.withOpacity(0.3)),
            ),
            onPressed: onTap,
            icon: icon!,
            label: Text(
              title!,
              style: context.textTheme.headline1!.copyWith(
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
