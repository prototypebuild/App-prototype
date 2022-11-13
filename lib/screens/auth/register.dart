import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lefoode/api/global_helpers.dart';
import 'package:lefoode/api/master_validator.dart';
import 'package:lefoode/api/ui_overlays.dart';
import 'package:lefoode/screens/home.dart';
import 'package:lefoode/widgets/input.dart';
import 'package:lefoode/widgets/primary_button.dart';
import 'package:lefoode/widgets/v_space.dart';

import '../../constants/colors.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = "/auth/register";
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    phoneController.text = auth.currentUser!.phoneNumber!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Started"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              VSpace(),
              Text(
                "We'll need a few more details to get you started",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: ConstantColors.midGrayText,
                ),
              ),
              VSpace(s: 20),
              Input(
                validator:
                    MasterValidator.attach(flags: [ValidatorFlags.NonEmpty]),
                hintText: "Name",
                autofocus: true,
                autofillHints: [AutofillHints.name],
                nextInputAvailable: true,
                controller: nameController,
              ),
              VSpace(),
              Input(
                hintText: "Email",
                autofillHints: [AutofillHints.email],
                validator: MasterValidator.attach(flags: [
                  ValidatorFlags.NonEmpty,
                  ValidatorFlags.Email,
                ]),
                controller: emailController,
              ),
              VSpace(),
              Input(
                hintText: "Phone number",
                readOnly: true,
                controller: phoneController,
              ),
              Spacer(),
              PrimaryButton(
                  label: "Continue",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      GlobalHelpers.hideKeyboard();
                      UIOverlays.showLoadingOverlay(context);
                      await firestore
                          .collection("users")
                          .doc(auth.currentUser!.uid)
                          .set({
                        "name": nameController.text,
                        "email": emailController.text,
                        "phone": phoneController.text,
                      });
                      auth.currentUser!.updateDisplayName(nameController.text);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          HomeScreen.routeName, (route) => false);
                    }
                  }),
              VSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
