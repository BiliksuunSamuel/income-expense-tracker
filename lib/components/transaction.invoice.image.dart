import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class TransactionInvoiceImage extends StatelessWidget {
  final String filePath;
  final bool isAsset;
  const TransactionInvoiceImage(
      {super.key, required this.filePath, this.isAsset = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.getHeight(100),
      width: Dimensions.deviceWidth * 0.9,
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(Dimensions.getBorderRadius(10)),
          image: DecorationImage(
              image:
                  isAsset ? FileImage(File(filePath)) : NetworkImage(filePath),
              fit: BoxFit.cover)),
    );
  }
}
