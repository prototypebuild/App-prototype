import 'package:flutter/material.dart';
import 'package:lefoode/api/global_helpers.dart';
import 'package:lefoode/widgets/touchable_opacity.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final void Function()? onTap;
  final Color? color;
  final bool filled;
  const PrimaryButton({Key? key, this.onTap, required this.label, this.color,this.filled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        GlobalHelpers.hideKeyboard();
        onTap?.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: filled ? (color ?? Theme.of(context).primaryColor) : Colors.transparent,
          border: Border.all(
            color: color ?? Theme.of(context).primaryColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              color: filled ? Colors.white : Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
