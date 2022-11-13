import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lefoode/screens/auth/phone_auth.dart';
import 'package:lefoode/screens/home.dart';

class LaunchDecider extends StatefulWidget {
  static const String routeName = "/launch_decider";
  const LaunchDecider({Key? key}) : super(key: key);

  @override
  State<LaunchDecider> createState() => _LaunchDeciderState();
}

class _LaunchDeciderState extends State<LaunchDecider> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(PhoneAuthScreen.routeName, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
