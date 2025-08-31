import 'package:flutter/material.dart';
import 'package:ie_montrac/utils/dimensions.dart';

class ContentContainer extends StatelessWidget {
  final Widget? child;
  final double? padding;
  final Color? backgroundColor;
  const ContentContainer(
      {super.key, this.child, this.padding, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding ?? Dimensions.getPadding(20)),
      color: backgroundColor,
      child: child,
    );
  }
}
