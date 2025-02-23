import 'package:flutter/material.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';

class ProgressBar extends StatelessWidget {
  final double progress; // Value between 0.0 and 1.0
  final Color? progressColor;
  final Color? backgroundColor;
  final double? height;
  final double? borderRadius;
  final ValueChanged<double>? onChange; // Callback for progress changes
  const ProgressBar({
    Key? key,
    required this.progress,
    this.progressColor, // Default purple color
    this.backgroundColor, // Default light gray
    this.height,
    this.borderRadius,
    this.onChange, // Callback to capture changes
  })  : assert(progress >= 0.0 && progress <= 1.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerWidth = constraints.maxWidth;

        return GestureDetector(
          onPanUpdate: (details) {
            // Calculate new progress based on horizontal drag
            double newProgress =
                (details.localPosition.dx / containerWidth).clamp(0.0, 1.0);

            if (onChange != null) {
              onChange!(newProgress); // Trigger the onChange callback
            }
          },
          child: Stack(
            clipBehavior: Clip.none, // Ensures the bubble can go outside bounds
            children: [
              // Background progress bar
              Container(
                height: height ?? Dimensions.getHeight(13), // Adjust height
                decoration: BoxDecoration(
                  color: backgroundColor ?? Colors.grey[300],
                  borderRadius: BorderRadius.circular(
                    borderRadius ?? Dimensions.getBorderRadius(20),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    borderRadius ?? Dimensions.getBorderRadius(10),
                  ),
                  child: LinearProgressIndicator(
                    value: progress,
                    color: progressColor ?? AppColors.primaryColor,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),

              // Progress bubble
              Positioned(
                left: (containerWidth * progress) -
                    Dimensions.getWidth(28), // Adjust bubble's center
                top: -Dimensions.getHeight(
                    10), // Position above the progress bar
                child: Container(
                  height: Dimensions.getHeight(28),
                  width: Dimensions.getWidth(55),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(
                      Dimensions.getBorderRadius(25),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "${(progress * 100).toStringAsFixed(0)}%",
                      style: AppFontSize.fontSizeMedium(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
