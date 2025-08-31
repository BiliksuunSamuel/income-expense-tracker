import 'package:flutter/material.dart';

class AppView extends StatelessWidget {
  final Widget? body;
  final Widget? drawer;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  const AppView(
      {super.key, this.body, this.backgroundColor, this.drawer, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor:
          backgroundColor ?? Colors.white70.withValues(alpha: 0.95),
      body: body,
      drawer: drawer,
      appBar: appBar,
    );
  }
}
