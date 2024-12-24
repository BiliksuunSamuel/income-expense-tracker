import 'package:flutter/material.dart';

import '../components/svg.icon.dart';
import '../helper/resources.dart';
import '../theme/app.colors.dart';
import '../utils/dimensions.dart';

class FloatingActionMenuView extends StatelessWidget {
  final bool isVisible;
  final Function()? handleExpensePressed;
  final Function()? handleIncomePressed;
  final Function()? handleViewTransactionsPressed;

  const FloatingActionMenuView(
      {super.key,
      required this.isVisible,
      this.handleExpensePressed,
      this.handleIncomePressed,
      this.handleViewTransactionsPressed});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Positioned(
          bottom: Dimensions.getHeight(10),
          left: Dimensions.getWidth(40),
          child: Container(
            width: Dimensions.deviceWidth * 0.8,
            height: Dimensions.getHeight(185),
            padding: EdgeInsets.all(Dimensions.getPadding(10)),
            child: Stack(
              children: [
                Positioned(
                    bottom: Dimensions.getHeight(25),
                    left: Dimensions.deviceWidth / 2,
                    child: FloatingActionButton(
                        heroTag: "expense",
                        onPressed: handleExpensePressed ?? () {},
                        backgroundColor: AppColors.redColor,
                        shape: const CircleBorder(),
                        child: const SvgIcon(
                          path: Resources.expense,
                        ))),
                Positioned(
                  bottom: Dimensions.getHeight(75),
                  right: Dimensions.deviceWidth / 3.25,
                  child: FloatingActionButton(
                      heroTag: "exchange",
                      onPressed: handleViewTransactionsPressed ?? () {},
                      backgroundColor: AppColors.blueColor,
                      shape: const CircleBorder(),
                      child: const SvgIcon(
                        path: Resources.exchange,
                      )),
                ),
                Positioned(
                  bottom: Dimensions.getHeight(25),
                  right: Dimensions.deviceWidth / 2,
                  child: FloatingActionButton(
                    heroTag: "income",
                    onPressed: handleIncomePressed ?? () {},
                    backgroundColor: AppColors.greenColor,
                    shape: const CircleBorder(),
                    child: const SvgIcon(
                      path: 'assets/images/income.svg',
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
