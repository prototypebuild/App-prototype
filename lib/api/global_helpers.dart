import 'package:flutter/material.dart';

class GlobalHelpers {
  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
