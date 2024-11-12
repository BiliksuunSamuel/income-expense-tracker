import 'package:flutter/material.dart';
import 'package:ie_montrac/models/carousel.item.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';

class CarouselItemView extends StatelessWidget {
  final CarouselItem item;
  const CarouselItemView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: const BoxConstraints.expand().maxHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dimensions.getHeight(50),
          ),
          Container(
            height: Dimensions.getHeight(220),
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(item.image))),
          ),
          SizedBox(
            height: Dimensions.getHeight(15),
          ),
          Expanded(
              child: Column(
            children: [
              Text(
                item.title,
                style: AppFontSize.fontSizeTitle(
                    fontSize: Dimensions.getFontSize(36),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Dimensions.getHeight(10),
              ),
              Text(
                item.description,
                style: AppFontSize.fontSizeTitle(color: Colors.grey),
                textAlign: TextAlign.center,
              )
            ],
          ))
        ],
      ),
    );
  }
}
