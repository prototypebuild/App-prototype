import 'package:flutter/material.dart';

class UIOverlays {
  static void showLoadingOverlay(BuildContext context,
      {bool canBeClosedByUser = false}) {
    showDialog(
      barrierDismissible: canBeClosedByUser,
      context: context,
      builder: (ctx) {
        return WillPopScope(
          onWillPop: () async => canBeClosedByUser,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: const SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}
