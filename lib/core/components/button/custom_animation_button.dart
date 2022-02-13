import 'package:flutter/material.dart';
import '../../extensions/context_extension.dart';

class CustomAnimationRoundedButton extends StatefulWidget {
  final String? title;
  final Icon? icon;
  final VoidCallback? onTap;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  const CustomAnimationRoundedButton({
    Key? key,
    this.title,
    this.onTap,
    this.icon,
    this.borderRadius = 64,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
  }) : super(key: key);

  @override
  State<CustomAnimationRoundedButton> createState() =>
      _CustomAnimationRoundedButtonState();
}

class _CustomAnimationRoundedButtonState
    extends State<CustomAnimationRoundedButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding!,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(widget.borderRadius!),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.themeColor.primary,
            borderRadius: BorderRadius.circular(widget.borderRadius!),
          ),
          child: TextButton(
            child: isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      const SizedBox(width: 20.0),
                      Text(
                        "Please wait....",
                        style: context.textTheme.headline2,
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.icon ?? const SizedBox.shrink(),
                      Text(
                        widget.title!,
                        style: context.textTheme.bodyMedium!.copyWith(
                            letterSpacing: 2,
                            color: context.theme.cardColor,
                            fontSize: 24),
                      ),
                    ],
                  ),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });

              widget.onTap?.call();

              await Future.delayed(Duration(seconds: 2));
              setState(() {
                isLoading = false;
              });
            },
          ),
        ),
      ),
    );
  }
}
