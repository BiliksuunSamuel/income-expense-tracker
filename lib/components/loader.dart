import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final Color backgroundColor;

  const Loader({super.key, this.backgroundColor = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return
        // Semi-transparent background
        Positioned.fill(
      child: Container(
        color: backgroundColor,
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white, // Loader color
            ),
          ),
        ), // Transparent or semi-transparent background
      ),
      // Centered loader
    );
  }
}
