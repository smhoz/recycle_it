import 'package:flutter/material.dart';
import 'package:hackathon_app/core/extensions/context_extension.dart';

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
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
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
            color: context.themeColor.primary,
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          child: TextButton(
            onPressed: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title!,
                  style: context.textTheme.bodyMedium!.copyWith(
                      letterSpacing: 2,
                      color: context.theme.cardColor,
                      fontSize: 24),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
