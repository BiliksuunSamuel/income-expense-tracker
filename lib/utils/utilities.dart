import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ie_montrac/helper/resources.dart';
import 'package:ie_montrac/theme/app.colors.dart';

Future<String> convertToBase64(String path) async {
  File imageFile = File(path);
  var bytes = await imageFile.readAsBytes();
  var base64String = base64Encode(bytes);
  return base64String;
}

//format date: hh:mm a, eg: 09:05 AM
String formatTime(DateTime date) {
  return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} ${date.hour < 12 ? "AM" : "PM"}";
}

//format date: yyyy-mm-dd
String formatDate(DateTime date) {
  return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}

//map transaction category to svg icon path
String mapCategoryToIcon(String category) {
  switch (category) {
    case "Food":
    case "food":
      return Resources.restaurant;
    case "Transport":
    case "transport":
    case "Transportation":
    case "transportation":
      return Resources.car;
    case "Shopping":
    case "shopping":
      return Resources.shopping;
    case "Others":
    case "others":
      return Resources.uncategorized;
    default:
      return Resources.uncategorized;
  }
}

//map transaction category to color
Color mapCategoryToColor(String category) {
  switch (category) {
    case "Food":
    case "food":
      return AppColors.redColor;
    case "Transport":
    case "transport":
    case "Transportation":
    case "transportation":
      return AppColors.blueColor;
    case "Shopping":
    case "shopping":
      return AppColors.orangeColor;
    case "Others":
    case "others":
      return AppColors.textGray;
    default:
      return AppColors.textGray;
  }
}

//convert month from int to string
String convertMonth(int month) {
  switch (month) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";
    default:
      return "January";
  }
}

//convert number to nth format
String convertToNth(int number) {
  if (number >= 11 && number <= 13) {
    return "${number}th";
  }
  switch (number % 10) {
    case 1:
      return "${number}st";
    case 2:
      return "${number}nd";
    case 3:
      return "${number}rd";
    default:
      return "${number}th";
  }
}

//datetime to long date time string: eg: 'Saturday 4 June 2021   16:20',
String longDateTimeString(DateTime date) {
  var day = convertToNth(date.day);
  var month = convertMonth(date.month);
  var value = "$day $month ${date.year}   ${date.toTimeOfDay}";
  return value;
}

//convert string to title case,
//make it an extension method for strings
extension TitleCase on String {
  String toTitleCase() {
    return this
        .split(" ")
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(" ");
  }
}

//create null or whitespace extension method for strings
extension IsNullOrWhiteSpace on String {
  bool get isNullOrWhiteSpace {
    return this == null || this.trim().isEmpty;
  }
}

//extension method to extract 12hr time from DateTime with PM/AM
extension ToTimeOfDay on DateTime {
  String get toTimeOfDay {
    return "${this.hour > 12 ? (this.hour - 12).toString().padLeft(2, "0") : this.hour.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')} ${this.hour < 12 ? "AM" : "PM"}";
  }
}
