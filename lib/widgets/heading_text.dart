import 'package:flutter/material.dart';
import 'package:lefoode/constants/colors.dart';

class HeadingText extends StatelessWidget {
  final String text;
  const HeadingText({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
        color: ConstantColors.midGrayText,
      ),
    );
  }
}
