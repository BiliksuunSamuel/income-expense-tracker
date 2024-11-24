import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/bottom-sheet/action.confirmation.bottom.sheet.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/components/response.modal.dart';
import 'package:ie_montrac/components/svg.icon.dart';
import 'package:ie_montrac/helper/resources.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';

class TransactionDetailsScreen extends StatefulWidget {
  const TransactionDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppView(
      body: Stack(
        children: [
          Column(
            children: [
              // Red header section
              Container(
                decoration: BoxDecoration(
                    color: AppColors.redColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft:
                            Radius.circular(Dimensions.getBorderRadius(20)),
                        bottomRight:
                            Radius.circular(Dimensions.getBorderRadius(20)))),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      // App bar
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Text(
                              'Detail Transaction',
                              style: AppFontSize.fontSizeTitle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      return ActionConfirmationBottomSheet(
                                        title: "Remove this transaction?",
                                        message:
                                            "Are you sure you want to remove this transaction",
                                        onApprove: () {
                                          Get.dialog(const ResponseModal(
                                            message:
                                                "Transaction removed successfully",
                                          ));
                                        },
                                      );
                                    });
                              },
                              child: const SvgIcon(
                                path: Resources.trashIcon,
                              ),
                            )
                          ],
                        ),
                      ),
                      // Amount and description
                      Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.getPadding(20),
                            bottom: Dimensions.getPadding(20),
                            right: Dimensions.getPadding(20)),
                        child: Column(
                          children: [
                            Text(
                              '\$120',
                              style: AppFontSize.fontSizeTitle(
                                color: Colors.white,
                                fontSize: Dimensions.getFontSize(48),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: Dimensions.getHeight(10)),
                            Text(
                              'Buy some grocery',
                              style: AppFontSize.fontSizeMedium(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: Dimensions.getHeight(10)),
                            Text(
                              'Saturday 4 June 2021   16:20',
                              style: AppFontSize.fontSizeMedium(
                                color: Colors.white.withOpacity(0.98),
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: Dimensions.getHeight(20)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // White content section
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Type, Category, Wallet section

                          SizedBox(height: Dimensions.getHeight(50)),
                          const Divider(),
                          SizedBox(
                            height: Dimensions.getHeight(15),
                          ),
                          // Description section
                          Text(
                            'Description',
                            style: AppFontSize.fontSizeMedium(
                                color: Colors.grey,
                                fontSize: Dimensions.getFontSize(18)),
                          ),
                          SizedBox(height: Dimensions.getHeight(10)),
                          Text(
                            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                            style: AppFontSize.fontSizeMedium(
                                fontSize: Dimensions.getFontSize(16)),
                          ),
                          SizedBox(height: Dimensions.getHeight(20)),
                          // Attachment section
                          Text(
                            'Attachment',
                            style: AppFontSize.fontSizeMedium(
                              color: Colors.grey,
                              fontSize: Dimensions.getFontSize(18),
                            ),
                          ),
                          SizedBox(height: Dimensions.getHeight(10)),
                          Container(
                            height: Dimensions.getHeight(100),
                            width: Dimensions.deviceWidth * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.getBorderRadius(10)),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        Resources.invoicePlaceholder),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(height: Dimensions.getHeight(20)),
                          // Edit button
                          PrimaryButton(title: "Edit")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              top: Dimensions.getHeight(250),
              left: Dimensions.deviceWidth * 0.025,
              child: Container(
                width: Dimensions.deviceWidth * 0.95,
                padding: EdgeInsets.all(Dimensions.getPadding(20)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(Dimensions.getBorderRadius(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.15),
                    width: Dimensions.getWidth(1.5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoColumn('Type', 'Expense'),
                    _buildInfoColumn('Category', 'Shopping'),
                    _buildInfoColumn('Wallet', 'Wallet'),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
