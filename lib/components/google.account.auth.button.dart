import 'package:flutter/material.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';

class GoogleAccountAuthButton extends StatelessWidget {
  final String title;
  final Function()? onPress;
  const GoogleAccountAuthButton({super.key, required this.title, this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(Dimensions.getPadding(1)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.getBorderRadius(10)),
            border: Border.all(
                width: Dimensions.getWidth(0.65), color: Colors.grey.shade500)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Dimensions.getHeight(45),
              height: Dimensions.getHeight(45),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/google.png"),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: Dimensions.getWidth(10),
            ),
            Text(
              title,
              style: AppFontSize.fontSizeTitle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
