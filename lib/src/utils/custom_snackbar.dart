import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController customSnackBar(String message, {bool isError = true}) {
  return Get.snackbar(
    isError ? "Error" : "Success",
    message,
    backgroundColor:
        isError ? const Color(0xffff3838) : const Color(0xff3ae374),
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 4),
    snackStyle: SnackStyle.FLOATING,
  );
}
