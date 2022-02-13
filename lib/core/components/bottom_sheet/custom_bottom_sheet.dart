import 'package:flutter/material.dart';
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
              decoration: BoxDecoration(
                color: context.theme.canvasColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    color: context.theme.focusColor,
                    offset: const Offset(0, -1),
                    blurRadius: 3,
                    spreadRadius: 3,
                  )
                ],
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.themeColor.primary.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: context.lowHeight,
                        width: context.highHeight,
                      ),
                    ),
                  ),
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
}
