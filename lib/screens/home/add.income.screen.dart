import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/category.controller.dart';
import 'package:ie_montrac/api/controllers/income.controller.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/custom.dropdown.dart';
import 'package:ie_montrac/components/custom.input.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/helper/resources.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:image_picker/image_picker.dart';

import '../../bottom-sheet/file.picker.bottom.sheet.dart';
import '../../components/custom.number.input.dart';
import '../../components/custom.switch.button.dart';
import '../../components/file.picker.button.dart';
import '../../components/link.button.dart';
import '../../components/transaction.document.card.dart';
import '../../components/transaction.invoice.image.dart';
import '../../constants/app.options.dart';
import '../../models/category.dart';
import '../../theme/app.font.size.dart';
import '../../utils/dimensions.dart';
import '../../utils/utilities.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  bool isRepeatEnabled = false;
  double amount = 0;
  var cameraImage;
  var galleryImage;
  var attachment;
  String? fileData;
  String? fileType;

  final ImagePicker _picker = ImagePicker();

  //handle document
  void _handleDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        dialogTitle: "Select a document",
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx']);
    if (result == null) {
      return;
    }
    attachment = result.files.first;
    var data = await convertToBase64(result.files.single.path!);
    setState(() {
      fileType = 'document';
      fileData = data;
    });
  }

  //handle gallery
  void _handleGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var data = await convertToBase64(image.path);
      setState(() {
        galleryImage = image;
        fileType = 'image';
        cameraImage = null;
        fileData = data;
      });
    }
  }

  //handle camera
  void _handleCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      var data = await convertToBase64(image.path);
      setState(() {
        cameraImage = image;
        fileType = 'image';
        fileData = data;
        galleryImage = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  //handle load data
  void _loadData() async {
    var controller = Get.find<CategoryController>();
    await controller.getCategories();
    var incomeController = Get.find<IncomeController>();
    incomeController.descriptionController.clear();
    incomeController.amountController.clear();
    incomeController.repeatFrequency = null;
    incomeController.repeatEndDate = DateTime.now();
    incomeController.repeatTransaction = false;
  }

  void _handleSubmit(Category? category) async {
    //extract file extension from cameraImage,galleryImage,attachment
    var fileExtension = cameraImage?.path.split('.').last ??
        galleryImage?.path.split('.').last ??
        attachment?.name.split('.').last;

    var fileName = cameraImage?.path.split('/').last ??
        galleryImage?.path.split('/').last ??
        attachment?.name;

    await Get.find<IncomeController>().addTransaction(
        category,
        fileData ?? Resources.invoicePlaceholder,
        fileName,
        fileExtension, () async {
      await Get.find<CategoryController>().getCategories();
    });
    //reset fields
    setState(() {
      cameraImage = null;
      galleryImage = null;
      attachment = null;
      fileData = null;
      fileType = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CategoryController(repository: Get.find()),
        builder: (categoryController) {
          return GetBuilder(
              init: IncomeController(repository: Get.find()),
              builder: (controller) {
                return AppView(
                  backgroundColor: Colors.white,
                  body: Stack(
                    children: [
                      CustomScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        slivers: [
                          const SliverAppBar(
                            pinned: true,
                            automaticallyImplyLeading: false,
                            backgroundColor: AppColors.greenColor,
                            title: AppHeaderTitle(
                              title: "Income",
                              titleColor: Colors.white,
                              iconColor: Colors.white,
                            ),
                          ),
                          SliverFillRemaining(
                            child: Container(
                              padding: EdgeInsets.zero,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            Dimensions.getBorderRadius(30)),
                                        bottomRight: Radius.circular(
                                            Dimensions.getBorderRadius(30))),
                                    child: Container(
                                      color: AppColors.greenColor,
                                      width: const BoxConstraints.expand()
                                          .maxWidth,
                                      height: Dimensions.getHeight(180),
                                      padding: EdgeInsets.all(
                                          Dimensions.getPadding(20)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "How Much",
                                            style: AppFontSize.fontSizeTitle(
                                                color: Colors.white60,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    Dimensions.getFontSize(28)),
                                          ),
                                          SizedBox(
                                            height: Dimensions.getHeight(5),
                                          ),
                                          //there is white space to the left of the input
                                          CustomNumberInput(
                                            controller:
                                                controller.amountController,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 7,
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            Dimensions.getPadding(20)),
                                        height: const BoxConstraints.expand()
                                            .maxHeight,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    Dimensions.getBorderRadius(
                                                        30)),
                                                topRight: Radius.circular(
                                                    Dimensions.getBorderRadius(
                                                        30)))),
                                        child: ListView(
                                          padding: EdgeInsets.zero,
                                          children: [
                                            SizedBox(
                                              height: Dimensions.getHeight(10),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text("Add Category",
                                                    style: AppFontSize
                                                        .fontSizeSmall(
                                                            color: AppColors
                                                                .textGray)),
                                                LinkButton(
                                                  fontSize:
                                                      Dimensions.getFontSize(
                                                          16),
                                                  title:
                                                      controller.isAddCategory
                                                          ? "Choose Category"
                                                          : "Create +",
                                                  decoration:
                                                      TextDecoration.none,
                                                  onPress: () {
                                                    controller.setIsAddCategory(
                                                        !controller
                                                            .isAddCategory);
                                                  },
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: Dimensions.getHeight(20),
                                            ),
                                            CustomDropdown(
                                              hintText: "Category",
                                              label: "Select Category",
                                              selectedValue: categoryController
                                                  .selectedCategory,
                                              items:
                                                  categoryController.categories,
                                              itemLabel: (Category item) {
                                                return item.title;
                                              },
                                              onChanged: (Category? val) {
                                                categoryController
                                                    .selectedCategory = val;
                                              },
                                            ),
                                            SizedBox(
                                              height: Dimensions.getHeight(20),
                                            ),
                                            CustomInput(
                                              hintText: "Description",
                                              minLines: 2,
                                              controller: controller
                                                  .descriptionController,
                                            ),
                                            SizedBox(
                                              height: Dimensions.getHeight(20),
                                            ),
                                            FilePickerButton(
                                              onPress: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder:
                                                        (BuildContext btx) {
                                                      return FilePickerBottomSheet(
                                                        onCamera: () {
                                                          Navigator.pop(btx);
                                                          _handleCamera();
                                                        },
                                                        onDocument: () {
                                                          Navigator.pop(btx);
                                                          _handleDocument();
                                                        },
                                                        onImage: () {
                                                          Navigator.pop(btx);
                                                          _handleGallery();
                                                        },
                                                      );
                                                    });
                                              },
                                            ),
                                            SizedBox(
                                              height: Dimensions.getHeight(20),
                                            ),
                                            Visibility(
                                                visible: fileType == 'image',
                                                child: TransactionInvoiceImage(
                                                  filePath: galleryImage
                                                          ?.path ??
                                                      cameraImage?.path ??
                                                      Resources
                                                          .invoicePlaceholder,
                                                )),
                                            Visibility(
                                                visible: fileType == 'document',
                                                child: TransactionDocument(
                                                    fileName:
                                                        attachment?.name)),
                                            SizedBox(
                                              height: Dimensions.getHeight(15),
                                            ),
                                            // Repeat Toggle
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Repeat',
                                                      style: AppFontSize
                                                          .fontSizeMedium(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Repeat transaction',
                                                      style: AppFontSize
                                                          .fontSizeMedium(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                CustomSwitchButton(
                                                  value: controller
                                                      .repeatTransaction,
                                                  onChanged: (value) {
                                                    controller
                                                        .setRepeatTransaction(
                                                            value);
                                                  },
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Dimensions.getHeight(20),
                                            ),
                                            // Repeat Frequency
                                            Visibility(
                                              visible:
                                                  controller.repeatTransaction,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Repeat Frequency',
                                                    style: AppFontSize
                                                        .fontSizeMedium(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Dimensions.getHeight(
                                                            10),
                                                  ),
                                                  CustomDropdown(
                                                    hintText: "Frequency",
                                                    selectedValue: controller
                                                        .repeatFrequency,
                                                    items: AppOptions
                                                        .transactionRepeatFrequencies,
                                                    itemLabel: (String item) {
                                                      return item;
                                                    },
                                                    onChanged: (String? val) {
                                                      controller
                                                          .setRepeatFrequency(
                                                              val);
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Dimensions.getHeight(
                                                            20),
                                                  ),
                                                  CustomInput(
                                                    prefixIcon: Container(
                                                      margin: EdgeInsets.only(
                                                          top: Dimensions
                                                              .getHeight(8),
                                                          left: Dimensions
                                                              .getWidth(10),
                                                          right: Dimensions
                                                              .getWidth(10)),
                                                      child: Text(
                                                        "Repeat Every ",
                                                        style: AppFontSize
                                                            .fontSizeMedium(),
                                                      ),
                                                    ),
                                                    hintText: "0",
                                                    keyboardType:
                                                        TextInputType.number,
                                                    suffixIcon: Container(
                                                      margin: EdgeInsets.only(
                                                          top: Dimensions
                                                              .getHeight(12),
                                                          left: Dimensions
                                                              .getWidth(10),
                                                          right: Dimensions
                                                              .getWidth(10)),
                                                      child: Text(
                                                        controller
                                                                .repeatFrequency ??
                                                            "Days",
                                                        style: AppFontSize
                                                            .fontSizeMedium(),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Dimensions.getHeight(
                                                            20),
                                                  ),
                                                  //EndDate: material calendar picker
                                                  CustomInput(
                                                    hintText:
                                                        "Repeat Transaction Until",
                                                    label:
                                                        "Repeat Transaction Until",
                                                    controller:
                                                        TextEditingController(
                                                            text: formatDate(
                                                                controller
                                                                    .repeatEndDate!)),
                                                    suffixIcon: IconButton(
                                                        onPressed: () async {
                                                          var selectedDate =
                                                              await showDatePicker(
                                                                  context:
                                                                      context,
                                                                  firstDate:
                                                                      DateTime
                                                                          .now(),
                                                                  //now plus 3600 days
                                                                  lastDate: DateTime
                                                                          .now()
                                                                      .add(const Duration(
                                                                          days:
                                                                              3600)));

                                                          controller
                                                              .setRepeatEndDate(
                                                                  selectedDate ??
                                                                      DateTime
                                                                          .now());
                                                        },
                                                        icon: const Icon(
                                                            Icons
                                                                .calendar_month_outlined,
                                                            color:
                                                                Colors.grey)),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: Dimensions.getHeight(20),
                                            ),
                                            PrimaryButton(
                                              title: "Continue",
                                              disabled: controller.loading,
                                              onPressed: () {
                                                _handleSubmit(categoryController
                                                    .selectedCategory);
                                              },
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                          visible:
                              controller.loading || categoryController.loading,
                          child: const Loader())
                    ],
                  ),
                );
              });
        });
  }
}
