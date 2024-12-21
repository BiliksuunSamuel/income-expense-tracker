import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/budget.controller.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

import '../../components/custom.input.dart';
import '../../components/primary.button.dart';
import '../../utils/dimensions.dart';

class CreateBudgetCategoryScreen extends StatefulWidget {
  const CreateBudgetCategoryScreen({super.key});

  @override
  State<CreateBudgetCategoryScreen> createState() =>
      _CreateBudgetCategoryScreenState();
}

class _CreateBudgetCategoryScreenState
    extends State<CreateBudgetCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BudgetController(repository: Get.find()),
        builder: (controller) {
          return AppView(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    const SliverAppBar(
                      pinned: true,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      title: AppHeaderTitle(
                        title: "Add Budget Category",
                      ),
                    ),
                    SliverFillRemaining(
                      child: ContentContainer(
                        child: ListView(padding: EdgeInsets.zero, children: [
                          CustomInput(
                            hintText: "Category Name",
                            controller: controller.categoryTitleController,
                          ),
                          SizedBox(
                            height: Dimensions.getHeight(20),
                          ),
                          CustomInput(
                            hintText: "Category Description",
                            minLines: 2,
                            controller:
                                controller.categoryDescriptionController,
                          ),
                          SizedBox(
                            height: Dimensions.getHeight(20),
                          ),
                          PrimaryButton(
                            title: "Submit",
                            onPressed: () async {
                              await controller.createCategory();
                            },
                            disabled: controller.loading,
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
                Visibility(
                  visible: controller.loading,
                  child: const Loader(),
                )
              ],
            ),
          );
        });
  }
}
