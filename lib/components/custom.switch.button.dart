import 'package:flutter/cupertino.dart';

import '../theme/app.colors.dart';

class CustomSwitchButton extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  final Color? activeColor;
  const CustomSwitchButton(
      {super.key,
      required this.value,
      required this.onChanged,
      this.activeColor});

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor ?? AppColors.primaryColor,
    );
  }
}
