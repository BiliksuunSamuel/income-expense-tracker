import 'package:flutter/material.dart';

import '../components/bottom.sheet.container.dart';
import '../components/custom.filepicker.button.dart';
import '../helper/resources.dart';
import '../utils/dimensions.dart';

class FilePickerBottomSheet extends StatelessWidget {
  const FilePickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(children: [
      SizedBox(
        height: Dimensions.getHeight(20),
      ),
      const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: CustomFilePickerButton(
              title: "Camera",
              iconPath: Resources.camera,
            )),
            Expanded(
                child: CustomFilePickerButton(
              title: "Image",
              iconPath: Resources.gallery,
            )),
            Expanded(
                child: CustomFilePickerButton(
              title: "Document",
              iconPath: Resources.file,
            )),
          ]),
      SizedBox(
        height: Dimensions.getHeight(30),
      )
    ]);
  }
}
