import 'package:flutter/material.dart';
import 'package:ie_montrac/utils/dimensions.dart';

class ContentContainer extends StatelessWidget {
  final Widget? child;
  final double? padding;
  const ContentContainer({super.key, this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding ?? Dimensions.getPadding(20)),
      child: child,
    );
  }
}
