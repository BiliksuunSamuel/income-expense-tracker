import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/components/carousel.item.view.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/screens/auth/login.screen.dart';
import 'package:ie_montrac/screens/auth/register.screen.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/utils/carousel.data.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _scrollIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppView(
      body: ContentContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Dimensions.deviceHeight * 0.65,
              child: CarouselSlider(
                items: getCarouselData().map((item) {
                  return CarouselItemView(item: item);
                }).toList(),
                options: CarouselOptions(
                  height: Dimensions.deviceHeight * 0.68,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: _scrollIndex,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (pageIndex, _) {
                    setState(() {
                      _scrollIndex = pageIndex;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.getHeight(15),
              child: Center(
                child: ListView.builder(
                    itemCount: getCarouselData().length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext ctx, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.getWidth(5)),
                        width: Dimensions.getHeight(15),
                        decoration: BoxDecoration(
                            color: _scrollIndex == index
                                ? AppColors.primaryColor
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(
                                Dimensions.getBorderRadius(100))),
                      );
                    }),
              ),
            ),
            SizedBox(
              height: Dimensions.deviceHeight * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PrimaryButton(
                    title: "Sign Up",
                    onPressed: () {
                      Get.offAll(() => const RegisterScreen());
                    },
                  ),
                  SizedBox(height: Dimensions.getHeight(15)),
                  PrimaryButton(
                    title: "Login",
                    bgcolor: AppColors.primaryColor.withOpacity(0.15),
                    textColor: AppColors.primaryColor,
                    onPressed: () {
                      Get.offAll(() => const LoginScreen());
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
