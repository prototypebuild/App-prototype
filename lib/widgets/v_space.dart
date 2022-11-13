import 'package:flutter/material.dart';

class VSpace extends StatelessWidget {
  // s stands for spacing
  final double s;
  final bool isHorizontal;
  const VSpace({Key? key, this.s = 10, this.isHorizontal = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) return SizedBox(width: s);
    return SizedBox(height: s);
  }
}
