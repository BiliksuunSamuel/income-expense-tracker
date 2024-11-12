import 'package:ie_montrac/models/carousel.item.dart';

List<CarouselItem> getCarouselData() {
  return [
    CarouselItem(
        title: "Gain total control of your money",
        description: "Become your own money manager and make every cent count",
        image: "assets/images/control.png"),
    CarouselItem(
        title: "Know where your money goes",
        description:
            "Track your transactions easily, with categories and financial report",
        image: "assets/images/money.png"),
    CarouselItem(
        title: "Planning ahead",
        description: "Setup budget for each category and be in control",
        image: "assets/images/plan.png")
  ];
}
