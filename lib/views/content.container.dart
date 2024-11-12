import 'package:flutter/material.dart';
import 'package:ie_montrac/utils/dimensions.dart';

class ContentContainer extends StatelessWidget {
  final Widget? child;
  const ContentContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.getPadding(20)),
      child: child,
    );
  }
}
