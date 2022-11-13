import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget {
  final double delay;
  final Widget child;
  const FadeAnimation({required this.delay, required this.child,Key? key}) : super(key: key);

  @override
  State<FadeAnimation> createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> {
  bool isVisible = false;
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: (125 * widget.delay).round()))
        .then((value) {
      if (mounted) {
        setState(() {
          isVisible = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1 : 0,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      child: widget.child,
    );
  }
}
