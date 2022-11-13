import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lefoode/api/global_helpers.dart';
import 'package:lefoode/api/ui_overlays.dart';
import 'package:lefoode/screens/auth/register.dart';
import 'package:lefoode/screens/home.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../constants/colors.dart';
import '../../widgets/input.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/v_space.dart';

class PhoneAuthScreen extends StatefulWidget {
  static const String routeName = '/auth/phone_auth';
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController numberController = TextEditingController();
  bool loading = false;
  int? otpResendToken;

  void login(BuildContext context) async {
    setState(() {
      loading = true;
    });
    UIOverlays.showLoadingOverlay(context);
    await auth.verifyPhoneNumber(
      phoneNumber: "+91${numberController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!

        // Sign the user in (or link) with the auto-generated credential
        await auth.signInWithCredential(credential);

        checkRegistration();
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }

        setState(() {
          loading = false;
        });

        Navigator.of(context)
            .popUntil(ModalRoute.withName(PhoneAuthScreen.routeName));
        // Handle other errors
      },
      codeSent: (String verificationId, int? resendToken) async {
        otpResendToken = resendToken;
        Navigator.of(context)
            .popUntil(ModalRoute.withName(PhoneAuthScreen.routeName));
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10.0),
            ),
          ),
          isScrollControlled: true,
          isDismissible: false,
          builder: (ctx) {
            TextEditingController pincodeController = TextEditingController();
            return WillPopScope(
              onWillPop: () async {
                setState(() {
                  loading = false;
                });
                return true;
              },
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  // height: MediaQuery.of(context).size.height * 0.3,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      VSpace(s: 20),
                      Container(
                        width: double.infinity,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "Enter OTP Sent on ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: ConstantColors.midGrayText,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "+91 " + numberController.text.trim(),
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                // recognizer: _longPressRecognizer,
                              ),
                              // TextSpan(text: ' Edit?'),
                            ],
                          ),
                        ),
                      ),
                      VSpace(s: 50),
                      PinCodeTextField(
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        cursorColor: Colors.black,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.transparent,
                          selectedFillColor: Colors.transparent,
                          inactiveColor: ConstantColors.midGrayText,
                          inactiveFillColor: Colors.transparent,
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        enableActiveFill: true,
                        controller: pincodeController,
                        onCompleted: (v) async {
                          UIOverlays.showLoadingOverlay(context);
                          // Update the UI - wait for the user to enter the SMS code
                          String smsCode = v;

                          // Create a PhoneAuthCredential with the code
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: verificationId,
                                  smsCode: smsCode);

                          try {
                            // Sign the user in (or link) with the credential
                            await auth.signInWithCredential(credential);
                          } catch (e) {
                            var error = e as FirebaseAuthException;
                            Fluttertoast.showToast(
                                msg: error.message ?? error.code);
                            setState(() {
                              loading = false;
                            });
                            Navigator.of(context).popUntil(
                                ModalRoute.withName(PhoneAuthScreen.routeName));
                            return;
                          }
                          checkRegistration();
                        },
                        onChanged: (value) {
                          print(value);
                        },
                        beforeTextPaste: (text) {
                          if (text != null &&
                              num.tryParse(text) != null &&
                              text.length == 6) {
                            return true;
                          }
                          return false;
                        },
                        appContext: context,
                      ),
                      VSpace(s: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      forceResendingToken: otpResendToken,
    );
  }

  void checkRegistration() async {
    var userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();
    Navigator.of(context)
        .popUntil(ModalRoute.withName(PhoneAuthScreen.routeName));
    if (userDoc.exists) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(RegistrationScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Container(
            height: 250,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 50),
            child: Text(
              "Le'Foode",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                letterSpacing: 5,
                color: ConstantColors.primary,
              ),
            ),
          ),
          Text(
            "Enter phone number",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
              color: ConstantColors.midGrayText,
            ),
          ),
          VSpace(s: 50),
          TextField(
            maxLength: 10,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            controller: numberController,
            keyboardType: TextInputType.phone,
            autofocus: true,
            onChanged: (value) {
              if (value.length == 10 && int.tryParse(value) != null) {
                GlobalHelpers.hideKeyboard();

                if (loading) return;
                login(context);
              }
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                suffixIcon: IconButton(
                  icon: Icon(Icons.close_rounded),
                  onPressed: numberController.clear,
                ),
                // prefix: Text("+91 |   "),
                prefixText: "+91 |   "),
          ),
          VSpace(s: 50),
          PrimaryButton(
            label: "SEND OTP",
            filled: true,
            onTap: () {
              if (loading) return;
              login(context);
            },
            color: loading ? Colors.grey : null,
          ),
        ],
      ),
    );
  }
}
