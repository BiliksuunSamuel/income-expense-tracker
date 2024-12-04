import 'package:flutter/material.dart';

import '../components/bottom.sheet.container.dart';
import '../components/custom.filepicker.button.dart';
import '../helper/resources.dart';
import '../utils/dimensions.dart';

class FilePickerBottomSheet extends StatelessWidget {
  final Function()? onCamera;
  final Function()? onImage;
  final Function()? onDocument;

  const FilePickerBottomSheet(
      {super.key, this.onCamera, this.onDocument, this.onImage});

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(children: [
      SizedBox(
        height: Dimensions.getHeight(20),
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: CustomFilePickerButton(
              onPress: onCamera,
              title: "Camera",
              iconPath: Resources.camera,
            )),
            Expanded(
                child: CustomFilePickerButton(
              onPress: onImage,
              title: "Image",
              iconPath: Resources.gallery,
            )),
            Expanded(
                child: CustomFilePickerButton(
              onPress: onDocument,
              title: "Document",
              iconPath: Resources.file,
            )),
          ]),
      SizedBox(
        height: Dimensions.getHeight(20),
      )
    ]);
  }
}
