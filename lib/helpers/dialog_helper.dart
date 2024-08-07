import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global_widgets/custom_responsize_textview.dart';


class DialogHelper {
  //show error dialog
  static void showErroDialog({String title = 'Error', String? description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.bodyMedium,
              ),
              Text(
                description ?? '',
                style: Get.textTheme.labelLarge,
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: Text('Okay'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show toast
  //show snack bar
  //show loading
  static void showLoading([String? message,bool? barrier=false]) {
    Get.dialog(
      barrierColor: Colors.black.withOpacity(0.7),
      barrierDismissible: barrier??true,
      Dialog(
        child: DecoratedBox(
          decoration: BoxDecoration(
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                CircularProgressIndicator(),
                SizedBox(height: 20),
                CustomText(labeltext: message ?? 'Loading...'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}